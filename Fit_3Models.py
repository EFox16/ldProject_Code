#!/usr/bin/python

"""Fits an exponential, gamma, and polynomial function to a data set. FILE NAME INPUT REQUIRED"""

___author__ = "Emma Fox (e.fox16@imperial.ac.uk)"
__version__ = "0.0.1"

########################################################################
# IMPORTS                                                              #
########################################################################

import sys
from lmfit import minimize, Minimizer, Parameters, Parameter, report_fit, fit_report
import numpy as np
import os
import csv

########################################################################
# LOAD DATA                                                            #
########################################################################
ldFile = open(sys.argv[1])

BPDist,r2Pear,D,DPrime,r2GLS=np.loadtxt(ldFile, usecols=(2,3,4,5,6), unpack=True)

x=BPDist
data=r2Pear

########################################################################
# EXPONENTIAL FUNCTION                                                 #
########################################################################
def EXP(paramsEXP, x, data):
	"""Modeling the reverse exponential decay"""
	init = paramsEXP['init']
	lam = paramsEXP['lam']
	model = init * np.exp(-lam * x)
	return model - data

#Create parameter set
paramsEXP = Parameters()
paramsEXP.add('init', value=1, max=1)
paramsEXP.add('lam', value=2)

#Fit with least squares
try:
	resultEXP = minimize(EXP, paramsEXP, args=(x,), kws={'data':data})
except:
	pass

	
########################################################################
# GAMMA FUNCTION                                                       #
########################################################################
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

#Fit with least squares
try:
	resultGAM = minimize(GAM, paramsGAM, args=(x,), kws={'data':data})
except:
	pass
	
	
########################################################################
# POLYNOMIAL FUNCTION                                                  #
########################################################################
def POLY(paramsPOLY, x, data):
	"""Polynomial function"""
	a = paramsPOLY['a']
	b = paramsPOLY['b']
	c = paramsPOLY['c']
	model = a*x**2 + b*x + c
	return model - data

#Create parameter set
paramsPOLY = Parameters()
paramsPOLY.add('a', value=1)
paramsPOLY.add('b', value=1)
paramsPOLY.add('c', value=1)

#Fit with least squares
try:
	resultPOLY = minimize(POLY, paramsPOLY, args=(x,), kws={'data':data})
except:
	pass
	
########################################################################
# EXAMINE OUTPUT                                                       #
########################################################################

try:
	print "resultEXP"
	report_fit(resultEXP)
except:
	print "empty"
try:
	print "resultGAM"
	report_fit(resultGAM)
except:
	print "empty"
try:
	print "resultPOLY"
	report_fit(resultPOLY)
except:
	print "empty"

########################################################################
# SAVE OUTPUT AS CSV                                                   #
########################################################################
try:
	EXP_init=resultEXP.params.valuesdict()['init']
	EXP_lam=resultEXP.params.valuesdict()['lam']
except:
	EXP_init="EMPTY"
	EXP_lam="EMPTY"
try:
	GAM_k=resultGAM.params.valuesdict()['k']
	GAM_t=resultGAM.params.valuesdict()['t']
except:
	GAM_k="EMPTY"
	GAM_t="EMPTY"
try:
	POLY_a=resultPOLY.params.valuesdict()['a']
	POLY_b=resultPOLY.params.valuesdict()['b']
	POLY_c=resultPOLY.params.valuesdict()['c']
except:
	POLY_a="EMPTY"
	POLY_b="EMPTY"
	POLY_c="EMPTY"

FileName, Exten = os.path.splitext(sys.argv[1])
FileName, Exten = os.path.splitext(FileName)
ResultName = '%s_FitParams.csv' % FileName

with open(ResultName, 'wb') as csvfile:
	ResultFile = csv.writer(csvfile, delimiter=',', quotechar='|')
	ResultFile.writerow(["Model", "Parameter", "Value"])
	ResultFile.writerow(["EXP", "init", EXP_init])
	ResultFile.writerow(["EXP", "lam", EXP_lam])
	ResultFile.writerow(["GAM", "k", GAM_k])
	ResultFile.writerow(["GAM", "t", GAM_t])
	ResultFile.writerow(["POLY", "a", POLY_a])
	ResultFile.writerow(["POLY", "b", POLY_b])
	ResultFile.writerow(["POLY", "c", POLY_c])
