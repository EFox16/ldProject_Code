#!/usr/bin/python

"""Practuce with minimize. Copied from http://lmfit.github.io/lmfit-py/parameters.html """

___author__ = "Emma Fox (e.fox16@imperial.ac.uk)"
__version__ = "0.0.1" 

##IMPORTS


##FUNCTIONS

#Objective function in simple format
#~ def residual(vars, x, data, eps_data):
    #~ amp = vars[0]
    #~ phaseshift = vars[1]
    #~ freq = vars[2]
    #~ decay = vars[3]

    #~ model = amp * sin(x * freq  + phaseshift) * exp(-x*x*decay)

    #~ return (data-model)/eps_data

#BENEFIT OF LMFIT 
#~ from lmfit import minimize, Parameters

#~ def residual(params, x, data, eps_data):
    #~ amp = params['amp']
    #~ pshift = params['phase']
    #~ freq = params['frequency']
    #~ decay = params['decay']

    #~ model = amp * sin(x * freq  + pshift) * exp(-x*x*decay)

    #~ return (data-model)/eps_data

#~ params = Parameters()
#~ params.add('amp', value=10)
#~ params.add('decay', value=0.007)
#~ params.add('phase', value=0.2)
#~ params.add('frequency', value=3.0)

#~ out = minimize(residual, params, args=(x, data, eps_data))


#will need 3-4. exponential, guassian, polynomial, double exponential


##IMPORTS
from lmfit import minimize, Minimizer, Parameters, Parameter, report_fit
import numpy as np
import matplotlib.pyplot as plt

#Data
x = np.linspace(0, 15, 301)
data = (5. * np.sin(2 * x - 0.1) * np.exp(-x*x*0.025) +
        np.random.normal(size=len(x), scale=0.2) )

plt.plot(x, data, 'ro')
plt.show()

#Function
def fcn2min(params, x, data):
	"""model decaying sine wave, subtract data"""
	amp = params['amp']
	shift = params['shift']
    omega = params['omega']
    decay = params['decay']
    model = amp * np.sin(x * omega + shift) * np.exp(-x*x*decay)
    return model - data
    #WHY RETURN MODEL - DATA? #answer: must return residuals to be minimized 

#Create parameter set
params = Parameters()
params.add('amp',   value= 10,  min=0)
params.add('decay', value= 0.1)
params.add('shift', value= 0.0, min=-np.pi/2., max=np.pi/2)
params.add('omega', value= 3.0)

#Fit with least sqaures
minner = Minimizer(fcn2min, params, fcn_args=(x, data))
kws  = {'options': {'maxiter':10}}
result = minner.minimize()

#Final Result
final = data + result.residual

#Error Report
report_fit(result)

#Plot Results
try:
    import pylab
    pylab.plot(x, data, 'k+')
    pylab.plot(x, final, 'r')
    pylab.show()
except:
    pass
    
    


























