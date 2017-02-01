#!/usr/bin/python

"""Reading in ld files to get their data"""

___author__ = "Emma Fox (e.fox16@imperial.ac.uk)"
__version__ = "0.0.1"

##IMPORTS
import sys

##FUNCTIONS
ldFile = open(sys.argv[1])

row_format = []
for line in ldFile:
	row_format.append(line.strip().split('\t'))
column_format = zip(*row_format)	

SNP1 = list(column_format[0])
SNP2 = list(column_format[1])
BPDist = map(int, list(column_format[2]))
r2Pear = map(float, list(column_format[3]))
D = map(float, list(column_format[4]))
DPrime = map(float, list(column_format[5]))
r2GLS = map(float, list(column_format[6]))

