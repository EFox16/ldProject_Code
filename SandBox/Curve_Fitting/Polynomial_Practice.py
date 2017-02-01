#!/usr/bin/python

"""Tutorial for fitting a polynomial curve using curve_fit. Copied from a response at http://stackoverflow.com/questions/3433486/how-to-do-exponential-and-logarithmic-curve-fitting-in-python-i-found-only-poly """

___author__ = "Emma Fox (e.fox16@imperial.ac.uk)"
__version__ = "0.0.1" 

##IMPORTS

import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
import numpy as np
import sympy as sym

##FUNCTIONS

#Create data
x = np.linspace(0, 3, 50)
y = np.exp(x)

#Plot data
plt.plot(x, y, 'ro', label="Original Data")

#Force into np.array of floats
x = np.array(x, dtype=float)
y = np.array(y, dtype=float)

#Try a function you guessed
def func(x, a, b, c, d):
	return a*x**3 + b*x**2 + c*x + d

#Try Curve Fitting
popt, pcov = curve_fit(func, x, y)

#See numerical results
print "a = %s , b = %s, c = %s, d = %s" % (popt[0], popt[1], popt[2], popt[3])

#View new plot
plt.plot(x, func(x, *popt), label="Fitted Curve")
plt.legend(loc='upper left')
plt.show()
