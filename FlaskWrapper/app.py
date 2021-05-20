from flask import Flask
from urllib import request

app = Flask(__name__)

@app.route("/")
def home():
    return "Welcome to Flask Wrapper"

@app.route("/flask1/")
@app.route("/flask1/<path:path>")
def flask1(path="main.py"):
	return request.urlopen("http://localhost:5001/" + path).read()

@app.route("/flask2/")
@app.route("/flask2/<path:path>")
def flask2(path="app.py"):
	return request.urlopen("http://localhost:5002/" + path).read()


if __name__ == "__main__":
    app.run(host="127.0.0.1", debug=True, port=5000)
