#Packages
import sys
from lmfit import minimize, Minimizer, Parameters, Parameter, report_fit, fit_report
import numpy as np
import os
import csv

#Data
BPDist,r2Pear,D,DPrime,r2GLS=np.loadtxt(ldFile, usecols=(2,3,4,5,6), unpack=True)

x=BPDist/100000
data=r2Pear

#Equations

def EXP(paramsEXP, x, data):
	"""Modeling the reverse exponential decay"""
	init = paramsEXP['init']
	lam = paramsEXP['lam']
	model = init * np.exp(-lam * x)
	return model - data

#Create parameter set
paramsEXP = Parameters()
paramsEXP.add('init', value=1)
paramsEXP.add('lam', value=2)

def GAM(paramsGAM, x, data):
	"""Polynomial function"""
	k = paramsGAM['k']
	t = paramsGAM['t']
	model = np.exp(-x * k) * x**t
	return model - data

#Create parameter set
paramsGAM = Parameters()
paramsGAM.add('k', value=1)
paramsGAM.add('t', value=1)

def POLY1(paramsPOLY1, x, data):
	"""Polynomial function"""
	a = paramsPOLY1['a']
	b = paramsPOLY1['b']
	model = a + b*x
	return model - data

paramsPOLY1 = Parameters()
paramsPOLY1.add('a', value=1)
paramsPOLY1.add('b', value=1)

def POLY2(paramsPOLY2, x, data):
	"""Polynomial function"""
	a = paramsPOLY2['a']
	b = paramsPOLY2['b']
	c = paramsPOLY2['c']
	model = a + b*x + c*x**2
	return model - data

#Create parameter set
paramsPOLY2 = Parameters()
paramsPOLY2.add('a', value=1)
paramsPOLY2.add('b', value=1)
paramsPOLY2.add('c', value=1)

def POLY3(paramsPOLY3, x, data):
	"""Polynomial function"""
	a = paramsPOLY3['a']
	b = paramsPOLY3['b']
	c = paramsPOLY3['c']
	d = paramsPOLY3['d']
	model = a + b*x + c*x**2 + d*x**3
	return model - data

#Create parameter set
paramsPOLY3 = Parameters()
paramsPOLY3.add('a', value=1)
paramsPOLY3.add('b', value=1)
paramsPOLY3.add('c', value=1)
paramsPOLY3.add('d', value=1)

def POLY4(paramsPOLY4, x, data):
	"""Polynomial function"""
	a = paramsPOLY4['a']
	b = paramsPOLY4['b']
	c = paramsPOLY4['c']
	d = paramsPOLY4['d']
	e = paramsPOLY4['e']
	model = a + b*x + c*x**2 + d*x**3 + e*x**4
	return model - data

#Create parameter set
paramsPOLY4 = Parameters()
paramsPOLY4.add('a', value=1)
paramsPOLY4.add('b', value=1)
paramsPOLY4.add('c', value=1)
paramsPOLY4.add('d', value=1)
paramsPOLY4.add('e', value=1)

def POLY5(paramsPOLY5, x, data):
	"""Polynomial function"""
	a = paramsPOLY5['a']
	b = paramsPOLY5['b']
	c = paramsPOLY5['c']
	d = paramsPOLY5['d']
	e = paramsPOLY5['e']
	f = paramsPOLY5['f']
	model = a + b*x + c*x**2 + d*x**3 + e*x**4 + f*x**5
	return model - data

#Create parameter set
paramsPOLY5 = Parameters()
paramsPOLY5.add('a', value=1)
paramsPOLY5.add('b', value=1)
paramsPOLY5.add('c', value=1)
paramsPOLY5.add('d', value=1)
paramsPOLY5.add('e', value=1)
paramsPOLY5.add('f', value=1)



#Fitting
AICList=[]

resultEXP=minimize(EXP, paramsEXP, args=(x,), kws={'data':data})
report_fit(resultEXP)
AICList.append(resultEXP.aic)

resultGAM=minimize(GAM, paramsGAM, args=(x,), kws={'data':data})
report_fit(resultGAM)
AICList.append(resultGAM.aic)

resultPOLY1=minimize(POLY1, paramsPOLY1, args=(x,), kws={'data':data})
report_fit(resultPOLY1)
AICList.append(resultPOLY1.aic)

resultPOLY2=minimize(POLY2, paramsPOLY2, args=(x,), kws={'data':data})
report_fit(resultPOLY2)
AICList.append(resultPOLY2.aic)

resultPOLY3=minimize(POLY3, paramsPOLY3, args=(x,), kws={'data':data})
report_fit(resultPOLY3)
AICList.append(resultPOLY3.aic)

resultPOLY4=minimize(POLY4, paramsPOLY4, args=(x,), kws={'data':data})
report_fit(resultPOLY4)
AICList.append(resultPOLY4.aic)

resultPOLY5=minimize(POLY5, paramsPOLY5, args=(x,), kws={'data':data})
report_fit(resultPOLY5)
AICList.append(resultPOLY5.aic)

print AICList
min(AICList)
