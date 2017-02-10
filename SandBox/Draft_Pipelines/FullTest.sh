#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: Calculate.sh
# Desc: Pipeline using ms to simulate, ANGSD to transform the files, and ngsLD to analyze with command line argument inputs
# Arguments: set name, number of samples, number of repetitions, theta, number of sites, sequencing depth, error rate, AND exponential growth rate OR bottleneck time and magnitude 

########################################################################
# RUN SIMULATION                                                       #
########################################################################

if [ $# = 7 ]
then  
	echo $2
	#bash Calculate_StringInput.sh $1 $2 $3 $4 $5 $6 $7
elif [ $# = 8 ]
then
	SimEvent=printf $8
	echo $SimEvent
	#bash Calculate_StringInput.sh $1 $2 $3 $4 $5 $6 $7 $8
fi

#~ ########################################################################
#~ # MODEL FITTING                                                        #
#~ ########################################################################

#~ python Fit_3Models.py $1_Results/$1_reads.testLD.ld

#~ ########################################################################
#~ # PLOT FITTED PARAMETERS 											   #
#~ ########################################################################

#~ Rscript Graphing_FittedModels.R $1_Results/$1_reads.testLD.ld $1_Results/$1_reads_FitParams.csv
