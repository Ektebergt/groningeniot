import matplotlib.pyplot as plt

def plot(x, y):
        plt.plot(x, y)

        plt.xlabel('Tijd')
        plt.xticks(fontsize = 5)
        plt.ylabel('Bewegingssnelheid')
        plt.title('testdata')

        plt.savefig('static/img/grafiek.png')