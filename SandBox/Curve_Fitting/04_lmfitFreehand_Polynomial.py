#!/usr/bin/python

"""Practicing minimize from lmfit with a polynomial function. Modelled after 03_lmfitFreehand_Exponential Decay and http://stackoverflow.com/questions/3433486/how-to-do-exponential-and-logarithmic-curve-fitting-in-python-i-found-only-poly"""

___author__ = "Emma Fox (e.fox16@imperial.ac.uk)"
__version__ = "0.0.1"

##IMPORTS
from lmfit import minimize, Minimizer, Parameters, Parameter, report_fit, fit_report
import numpy as np
import matplotlib.pyplot as plt

#Create data
x = np.linspace(0, 3, 50)
data = -5*x**2 - 5*x + 60 - np.random.normal(size=len(x), scale=1)

#Plot data
plt.plot(x, data, 'ro', label="Original Data")
plt.show()

#Function
def fcn2min(params, x, data):
	"""Polynomial function"""
	a = params['a']
	b = params['b']
	c = params['c']
	model = a*x**2 + b*x + c
	return model - data

#Create parameter set
params = Parameters()
params.add('a', value=-1, max=6, min=-6)
params.add('b', value=-1, max=6, min=-6)
params.add('c', value=30, max=100, min=20)

#Fit with least squares
minime = Minimizer(fcn2min, params, fcn_args=(x,data))
kws = {'options': {'maxiter':10}}
result = minime.minimize()

#Final line
final = data + result.residual

#Plot
plt.plot(x, data, 'ro', label="original data")
plt.plot(x, final, label="model line")
plt.show()

#Reports
report_fit(result)

out = minimize(fcn2min, params, args=(x,), kws={'data':data})
print(fit_report(out))



