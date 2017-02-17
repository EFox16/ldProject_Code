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

########################################################################
# POLYNOMIAL FUNCTIONS                                                 #
########################################################################
FunctionList=[]
ParamsList=[]

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

FunctionList.append(POLY4)
ParamsList.append(paramsPOLY4)

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

FunctionList.append(POLY5)
ParamsList.append(paramsPOLY5)

LetterList=['a', 'b', 'c', 'd', 'e', 'f']
name=1
counter=2
aicList=[]

FileName, Exten = os.path.splitext(sys.argv[1])
FileName, Exten = os.path.splitext(FileName)
ResultName = '%s_FitParams.csv' % FileName
with open(ResultName, 'wb') as csvfile:
	ResultFile = csv.writer(csvfile, delimiter=',', quotechar='|')
	ResultFile.writerow(["Model", "Parameter", "Value"])
	for i in range(0,5):
		ModelName="Model%d" % name
		result=(minimize(FunctionList[i], ParamsList[i], args=(x,), kws={'data':data}))
		aicList.append(result.aic)
		for i in range(0,counter):
			Letter=LetterList[i]
			NewVar=result.params.valuesdict()[Letter]
			ResultFile.writerow([ModelName, Letter, NewVar])
		counter=counter + 1
		name=name + 1

aicMin=min(aicList)
num=1
print "The best AIC value is %d" % aicMin
for i in range(0,5):
	BestName="POLY%d" % num 
	if aicList[i]==aicMin:
		print "The model with the best aic value is %s" % BestName
	num=num + 1



