#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: 
# Desc: 
# Arguments:  

########################################################################
# CREATE RESULTS FOLDER with subfolder for graphs                      #
########################################################################

mkdir ../Results/
mkdir ../Results/Fitted_Graphs

########################################################################
# RUN SIMULATION SCENARIOS                                             #
########################################################################

bash run_Simulation.sh Constant 40 1 800 1000000 20 0.01
bash run_Simulation.sh Expand 40 1 800 1000000 20 0.01 "-eN 0 3 -G 47.7"
bash run_Simulation.sh Bottleneck 40 1 800 1000000 20 0.01 "-eN 0 0.2 -eN 0.02 1"

########################################################################
# RUN ACTUAL DATA FITTING                                              #
########################################################################

# gunzip Data/LWK.ld.gz
bash run_DataAnalysis.sh LWK

# gunzip Data/TSI.ld.gz
bash run_DataAnalysis.sh TSI
