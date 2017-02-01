#!/usr/bin/python

"""Practicing minimize from lmfit with a gamma function. Modelled after 03_lmfitFreehand_Exponential Decay, http://www.intmath.com/blog/mathematics/factorials-and-the-gamma-function-4350, and https://en.wikipedia.org/wiki/Gamma_distribution"""

___author__ = "Emma Fox (e.fox16@imperial.ac.uk)"
__version__ = "0.0.1"

##IMPORTS
from lmfit import minimize, Minimizer, Parameters, Parameter, report_fit, fit_report
import numpy as np
import matplotlib.pyplot as plt

#Create data
x = np.linspace(0, 14, 45)
data = np.exp(-x * 1) * x**2 + np.random.normal(size=len(x), scale=0.01)

#Plot data
plt.plot(x, data, 'ro', label="Original Data")
plt.show()

#Function
def fcn2min(params, x, data):
	"""Polynomial function"""
	k = params['k']
	t = params['t']
	model = np.exp(-x * k) * x**t
	return model - data

#Create parameter set
params = Parameters()
params.add('k', value=1)
params.add('t', value=1)

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



