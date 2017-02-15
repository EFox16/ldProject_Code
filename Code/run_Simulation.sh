#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: Calculate.sh
# Desc: Pipeline using ms to simulate, ANGSD to transform the files, and ngsLD to analyze with command line argument inputs
# Arguments: set name, number of samples, number of repetitions, theta, number of sites, sequencing depth, error rate, AND exponential growth rate OR bottleneck time and magnitude 

########################################################################
# CREATE RESULTS FOLDER with reference sequence                        #
########################################################################

mkdir ../Results/$1
cd ../Results/$1

#Need to create fasta file
Rscript -e 'cat(">reference\n",paste(rep("A",1e6),sep="", collapse=""),"\n",sep="")' > reference.fa 

#creates reference file to avoid having to reference from beginning each time
samtools faidx reference.fa #should give reference.fa.fai


########################################################################
# SETTING VARIABLES                                                    #
########################################################################

SET_NAME=$1
N_SAM=$2 
N_REPS=$3 
THETA=$4 
RHO=$THETA
N_SITES=$5 
SEQ_DEPTH=$6 
ERR_RATE=$7

#Calculated variables
N_IND=$((N_SAM / 2))
MINMAF=$(echo "scale=2; 2/$N_SAM" | bc)

########################################################################
# RUN MS                                                               #
########################################################################

if [ $# = 7 ]
then
	../../../Packages/msdir/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES > $1.txt
elif [ $# = 8 ]
then
	SIMULATION_EVENTS=$8
	../../../Packages/msdir/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES $SIMULATION_EVENTS > $1.txt
fi

########################################################################
# CONVERT WITH ANGSD                                                   #
########################################################################

#Convert to glf
../../../Packages/angsd/misc/msToGlf -in $1.txt -out $1_reads -regLen $N_SITES -singleOut 1 -depth $SEQ_DEPTH -err $ERR_RATE -pileup 0 -Nsites 0

#Gives full sequence 
../../../Packages/angsd/angsd -glf $1_reads.glf.gz -fai reference.fa.fai -nInd $N_IND -doMajorMinor 1 -doPost 1 -doMaf 1 -doGeno 32 -out $1_reads.testLD -isSim 1 -minMaf $MINMAF

#Unzip output files
gunzip -f $1_reads.testLD.geno.gz

########################################################################
# RUN ngsLD                                                            #
########################################################################
#Create position file
zcat $1_reads.testLD.mafs.gz | cut -f 1,2 | tail -n +2 > $1_pos.txt
NS=`cat $1_pos.txt | wc -l` 

#Run ngsLD
../../../Packages/ngsLD/ngsLD --verbose 1 --n_ind $N_IND --n_sites $NS --geno $1_reads.testLD.geno --probs --pos $1_pos.txt --max_kb_dist 1000 --min_maf $MINMAF --rnd_sample 0.05 > $1.ld


########################################################################
# RETURN INPUT PARAMETERS                                              #
########################################################################

echo "SUMMARY OF PARAMETERS:" > $1_INPUT.txt
	echo >> $1_INPUT.txt
	echo "Number of Chromosomes="$N_SAM >> $1_INPUT.txt
	echo "Number of Repetitions="$N_REPS >> $1_INPUT.txt
	echo "Number of Individuals="$N_IND  >> $1_INPUT.txt
	echo "THETA="$THETA "RHO="$RHO >> $1_INPUT.txt 
	echo "Number of Sites="$N_SITES >> $1_INPUT.txt
	echo "Sequencing Depth="$SEQ_DEPTH >> $1_INPUT.txt
	echo "Error Rate="$ERR_RATE  >> $1_INPUT.txt
	echo "Number of Result Sites="$NS >> $1_INPUT.txt
if [ $# = 8 ]
then
	echo "Simulation Events="$SIMULATION_EVENTS >> $1_INPUT.txt
fi

########################################################################
# BIN DATA  														   #
########################################################################
Rscript ../../Code/Bin_ReadData.R $1.ld

########################################################################
# MODEL FITTING                                                        #
########################################################################

python ../../Code/Fit_5Models.py $1_Bin.csv

########################################################################
# PLOT FITTED PARAMETERS 											   #
########################################################################

Rscript ../../Code/Graphing_5FittedModels.R $1_Bin.csv $1_Bin_FitParams.csv

########################################################################
# BACK TO CODE FOLDER                                                  #
########################################################################

cd ../../Code
