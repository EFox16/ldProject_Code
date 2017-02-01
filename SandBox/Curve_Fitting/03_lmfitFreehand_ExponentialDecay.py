#!/usr/bin/python

"""Practicing minimize from lmfit with a decay function. Modelled after scripts found at http://lmfit.github.io/lmfit-py/parameters.html and http://lmfit.github.io/lmfit-py/parameters.html"""

___author__ = "Emma Fox (e.fox16@imperial.ac.uk)"
__version__ = "0.0.1"


##IMPORTS
from lmfit import minimize, Minimizer, Parameters, Parameter, report_fit, fit_report
import numpy as np
import matplotlib.pyplot as plt

#Create data
x = np.linspace(0, 3, 50)
data = 20*np.exp(-1.5*x) + np.random.normal(size=len(x), scale=0.1)

#Plot data
#~ plt.plot(x, data, 'ro', label="Original Data")
#~ plt.show()

#Function
def fcn2min(params, x, data):
	"""Modeling the reverse exponential decay"""
	init = params['init']
	lam = params['lam']
	model = init * np.exp(-lam * x)
	return model - data

#Create parameter set
params = Parameters()
params.add('init', value= 19, max=20)
params.add('lam', value=2)

#Fit with least squares
result = minimize(fcn2min, params, args=(x,), kws={'data':data})

#Model line
final = data + result.residual

#Reports
print(fit_report(result))

#Plot Results
import pylab
pylab.plot(x, data, 'k+')
pylab.plot(x, final, 'r')
pylab.show()


