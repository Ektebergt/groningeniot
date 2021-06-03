from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps
import MySQLdb.cursors
from handler import *
from plot import plot

import re
import os
import datetime


app = Flask(__name__)

# Change this to your secret key (can be anything, it's for extra protection)
app.secret_key = 'abcd123abcd'

# Enter your database connection details below
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'fcgroningeniot'

# Intialize MySQL
mysql = MySQL(app)

def verify(data):
    try:
        if len(data) == 25 and data[3:6] == ' , ' and data[10] == '/' and data[13] == '/' and data[16] == ' ' and data[-6] == ':' and data[-3] == ':':
            x = int(data[2])
            return True
        return False
    except:
        return False

# http://localhost:5000/pythonlogin/ - this will be the login page, we need to use both GET and POST requests
@app.route('/', methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM accounts WHERE username = %s', (username,))

        account = cursor.fetchone()

        if account:
            if check_password_hash(account.get('password'),password):
                session['loggedin'] = True
                session['id'] = account['id']
                session['username'] = account['username']
                return redirect(url_for('profile'))
        else:
            msg = 'Onjuiste gebruikersnaam/wachtwoord!'
    return render_template('index.html', msg=msg)

# http://localhost:5000/python/logout - this will be the logout page
@app.route('/logout')
def logout():
    # Remove session data, this will log the user out
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('username', None)
   # Redirect to login page
   return redirect(url_for('login'))

# http://localhost:5000/pythinlogin/register - this will be the registration page, we need to use both GET and POST requests
@app.route('/register', methods=['GET', 'POST'])
def register():
    # Output message if something goes wrong...
    msg = ''
    # Check if "username", "password" and "email" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form and 'dateofbirth' in request.form and 'length' in request.form and 'weight' in request.form and 'classid' in request.form:
        # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        passencrypt = generate_password_hash(password) 
        dateofbirth = request.form['dateofbirth']
        length = request.form['length']
        weight = request.form['weight']
        classid = request.form['classid']
        email = request.form['email']
                # Check if account exists using MySQL
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM accounts WHERE username = %s', (username,))
        account = cursor.fetchone()
        # If account exists show error and validation checks
        if account:
            msg = 'Account bestaat al!'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Onjuist e-mailadres!'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'De gebruikersnaam mag alleen tekens en cijfers bevatten!'
        elif not re.match(r'[A-Za-z0-9]+', password):
            msg = 'Wachtwoord mag alleen letters en cijfers bevatten!' 
        elif not username or not password or not email:
            msg = 'Gelieve het formulier in te vullen!'
        else:
            # Account doesnt exists and the form data is valid, now insert new account into accounts table
            cursor.execute('INSERT INTO accounts VALUES (NULL, %s, %s, %s, %s, %s, %s, %s)', (username, passencrypt, email, dateofbirth, length, weight, classid,))
            mysql.connection.commit()
            msg = 'Je hebt je succesvol geregistreerd!'
    elif request.method == 'POST':
        # Form is empty... (no POST data)
        msg = 'Gelieve het formulier in te vullen!'
    # Show registration form with message (if any)
    return render_template('register.html', msg=msg)

# http://localhost:5000/pythinlogin/home - this will be the home page, only accessible for loggedin users
@app.route('/home')
def home():
    # Check if user is loggedin
    if 'loggedin' in session:
        # connect to the database
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        # Check for "accel.txt" containing data
        try:
            # If "accel.txt" is found, verify and read data
            with open("accel.txt", "r") as file:
                # read "accel.txt"
                raw_data = file.read()
                # split based on linebreaks
                data = raw_data.splitlines()
                # for every line, do the following:
                for values in data:
                    # if data has been succesfully verified:
                    if verify(values):
                        # save the data in the database
                        cursor.execute(f"INSERT INTO data VALUES ({session['id']}, {values[:3]}, '{values[6:]}')")
                    else:
                        # otherwise, do nothing with the data
                        print('illegal value')
                        continue
                # save changes made to the database
                mysql.connection.commit()
            os.remove("accel.txt")
        except FileNotFoundError:
            # if the file didn't exist, do nothing
            print('accel.txt not found')
            pass
        # get values
        cursor.execute(f"SELECT datetime, value FROM data WHERE user_id = {session['id']}")
        data = cursor.fetchall()
        x = []
        y = []
        # add those values to a list
        for item in data:
            x.append(f"{item['datetime'].hour}:{item['datetime'].minute}:{item['datetime'].second}")
            y.append(item['value'])
        # plot the graph
        plot(x, y)
        # User is loggedin show them the home page
        return render_template('home.html', username=session['username'])
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))

# http://localhost:5000/pythinlogin/profile - this will be the profile page, only accessible for loggedin users
@app.route('/fcgroningeniot/profile')
def profile():
    # Check if user is loggedin
    if 'loggedin' in session:
        # We need all the account info for the user so we can display it on the profile page
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM accounts WHERE id = %s', (session['id'],))
        account = cursor.fetchone()
        # Show the profile page with account info
        return render_template('profile.html', account=account)

    return redirect(url_for('templates/login'))

    # User is not loggedin redirect to login page
    return redirect(url_for('templates/login'))

@app.route('/fcgroningeniot/profile/uploader', methods = ['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        f = request.files['file']
        f.save(f.filename)
    return redirect(url_for('profile'))

@app.route('/fcgroningeniot/profile/delete-account')
def account_verwijderen():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(f"DELETE FROM accounts WHERE id = {session['id']}")
        mysql.connection.commit()
        session.clear()
    return redirect(url_for('login'))

@app.route('/fcgroningeniot/profile/change-password', methods = ['GET', 'POST'])
def wachtwoord_aanpassen():
    msg = ''
    if 'loggedin' in session:
        if request.method == 'POST':
            password = request.form['password']
            passencrypt = generate_password_hash(password)
            if len(password) < 4:
                msg = 'Wachtwoord moet minstens 4 karakters lang zijn!'
            elif not re.match(r'[A-Za-z0-9]+', password):
                msg = 'Wachtwoord mag alleen letters en cijfers bevatten!'
            else:
                cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                cursor.execute(f"UPDATE accounts SET password = '{passencrypt}' WHERE id = {session['id']}")
                mysql.connection.commit()
                return redirect(url_for('login'))
        return render_template('change_password.html', msg=msg)
    return redirect(url_for('login'))
 
if __name__ == "__main__":
    app.run(host="127.0.0.1", debug=True, port=5001)