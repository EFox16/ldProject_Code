#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: ngsSim_Test_01.sh
# Desc: Testing ngsSim with super simple population
# Arguments: none
# Date: 27 DEC 2016

#PUT IN BIN SOMEHOW
#Test pop 1. very simple
NUM_POPS=1
NUM_SITES=50
DEPTH=2
P_VAR=1
ERROR=0.01
SEED=12345


../../Thesis/Packages/ngsSim/ngsSim -npop $NUM_POPS -nind 10 -nsites $NUM_SITES -pvar $P_VAR -depth $DEPTH -errate $ERROR -mfreq 0.005 -F 0 -model 1 -seed $SEED -outfiles 01_ngsSim_SinglePop/Test_01
