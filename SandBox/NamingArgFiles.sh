#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: Calculate.sh
# Desc: Pipeline using ms to simulate, ANGSD to transform the files, and ngsLD to analyze with command line argument inputs
# Arguments: set name, number of samples, number of repetitions, theta, number of sites, sequencing depth, error rate, AND exponential growth rate OR bottleneck time and magnitude 

########################################################################
# RUN SIMULATION                                                       #
########################################################################

echo $1.testLD.ld
echo $1_Results/$1_reads.testLD.ld
