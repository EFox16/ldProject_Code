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

def POLY1(paramsPOLY1, x, data):
	"""Polynomial function"""
	a = paramsPOLY['a']
	b = paramsPOLY['b']
	model = a + b*x
	return model - data
FunctionList.append(POLY1)

def POLY2(paramsPOLY2, x, data):
	"""Polynomial function"""
	a = paramsPOLY['a']
	b = paramsPOLY['b']
	c = paramsPOLY['c']
	model = a + b*x + c*x**2
	return model - data
FunctionList.append(POLY2)

def POLY3(paramsPOLY3, x, data):
	"""Polynomial function"""
	a = paramsPOLY['a']
	b = paramsPOLY['b']
	c = paramsPOLY['c']
	d = paramsPOLY['d']
	model = a + b*x + c*x**2 + d*x**3
	return model - data
FunctionList.append(POLY3)

def POLY4(paramsPOLY4, x, data):
	"""Polynomial function"""
	a = paramsPOLY['a']
	b = paramsPOLY['b']
	c = paramsPOLY['c']
	d = paramsPOLY['d']
	e = paramsPOLY['e']
	model = a + b*x + c*x**2 + d*x**3 + e*x**4
	return model - data
FunctionList.append(POLY4)

def POLY5(paramsPOLY5, x, data):
	"""Polynomial function"""
	a = paramsPOLY['a']
	b = paramsPOLY['b']
	c = paramsPOLY['c']
	d = paramsPOLY['d']
	e = paramsPOLY['e']
	f = paramsPOLY['f']
	model = a + b*x + c*x**2 + d*x**3 + e*x**4 + f*x**5
	return model - data
FunctionList.append(POLY5)
	
counter=2
name=1
ParamLetters=['a', 'b', 'c', 'd', 'e', 'f']
FileName, Exten = os.path.splitext(sys.argv[1])
FileName, Exten = os.path.splitext(FileName)
ResultName = '%s_FitParams.csv' % FileName
#~ with open(ResultName, 'wb') as csvfile:
	#~ ResultFile = csv.writer(csvfile, delimiter=',', quotechar='|')
	#~ ResultFile.writerow(["Model_Name","Variable","Value"])
	#~ for Model in FunctionList:
		#~ ModelName="Model%d" % name
		#~ paramsPOLY = Parameters()
		#~ for i in range(0,counter):
			#~ Var=ParamLetters[i]
			#~ paramsPOLY.add(Var, value=1)
		#~ result=minimize(Model, paramsPOLY, args=(x,), kws={'data':data})
		#~ for i in range(0,counter):
			#~ Letter=ParamLetters[i]
			#~ NewVar=result.params.valuesdict()[Letter]
			#~ ResultFile.writerow([ModelName, Letter, NewVar])
		#~ counter=counter + 1
		#~ name=name + 1


