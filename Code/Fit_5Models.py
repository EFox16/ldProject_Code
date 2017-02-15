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

x=BPDist/100000
data=r2Pear

FunctionList=[]
ParamsList=[]

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
paramsEXP.add('init', value=1)
paramsEXP.add('lam', value=2)

FunctionList.append(EXP)
ParamsList.append(paramsEXP)

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

FunctionList.append(GAM)
ParamsList.append(paramsGAM)

########################################################################
# POLYNOMIAL FUNCTIONS                                                 #
########################################################################

def POLY1(paramsPOLY1, x, data):
	"""Polynomial function"""
	a = paramsPOLY1['a']
	b = paramsPOLY1['b']
	model = a + b*x
	return model - data

paramsPOLY1 = Parameters()
paramsPOLY1.add('a', value=1)
paramsPOLY1.add('b', value=1)

FunctionList.append(POLY1)
ParamsList.append(paramsPOLY1)

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

FunctionList.append(POLY2)
ParamsList.append(paramsPOLY2)

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

FunctionList.append(POLY3)
ParamsList.append(paramsPOLY3)

########################################################################
# RUN FITS & SAVE RESULTS                                              #
########################################################################
LetterList=[['init', 'lam'], ['k', 't'], ['a', 'b'], ['a', 'b', 'c'],['a', 'b', 'c', 'd']]
ModelNameList=['EXP', 'GAM', 'POLY1', 'POLY2', 'POLY3']
counter=0
aicList=[]
resultList=[]

FileName, Exten = os.path.splitext(sys.argv[1])
ResultName = '%s_FitParams.csv' % FileName
with open(ResultName, 'wb') as csvfile:
	ResultFile = csv.writer(csvfile, delimiter=',', quotechar='|')
	ResultFile.writerow(["Model", "Parameter", "Value"])
	for i in range(0,5):
		ModelName=ModelNameList[i]
		result=(minimize(FunctionList[i], ParamsList[i], args=(x,), kws={'data':data}))
		resultList.append(result)
		aicList.append(result.aic)
		for i in range(0,len(LetterList[counter])):
			Letter=LetterList[counter][i]
			NewVar=result.params.valuesdict()[Letter]
			ResultFile.writerow([ModelName, Letter, NewVar])
		counter=counter + 1

aicMin=min(aicList)
print "The best AIC value is %d" % aicMin
for i in range(0,5):
	BestName=i + 1 
	if aicList[i]==aicMin:
		print "The model with the best aic value is from Model %d" % BestName

