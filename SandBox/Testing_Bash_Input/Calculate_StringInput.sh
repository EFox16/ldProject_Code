#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: Calculate.sh
# Desc: Pipeline using ms to simulate, ANGSD to transform the files, and ngsLD to analyze with command line argument inputs
# Arguments: set name, number of samples, number of repetitions, theta, number of sites, sequencing depth, error rate, AND exponential growth rate OR bottleneck time and magnitude 
# Date: 23 JAN 2017

########################################################################
# CREATE RESULTS FOLDER                                                #
########################################################################

mkdir $1_Results
cd $1_Results

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
N_IND=$((N_SAM / 2))

########################################################################
# RUN MS                                                               #
########################################################################

if [ $# = 7 ]
then  
	/usr/bin/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES > $1.txt
elif [ $# = 8 ]
then
	SIZE_CHANGE_CONDITIONS=$8
	/usr/bin/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES $SIZE_CHANGE_CONDITIONS > $1.txt
fi

########################################################################
# CONVERT WITH ANGSD                                                   #
########################################################################

#Convert to glf
/usr/bin/msToGlf -in $1.txt -out $1_reads -regLen $N_SITES -singleOut 1 -depth $SEQ_DEPTH -err $ERR_RATE -pileup 0 -Nsites 0

#Need to create fasta file
#Any way to tell it to use the site number instead of 1e6???????????????
Rscript -e 'cat(">reference\n",paste(rep("A",1e6),sep="", collapse=""),"\n",sep="")' > reference.fa 

#creates reference file to avoid having to reference from beginning each time
samtools faidx reference.fa #should give reference.fa.fai

#Gives full sequence 
/usr/bin/angsd -glf $1_reads.glf.gz -fai reference.fa.fai -nInd $N_IND -doMajorMinor 1 -doPost 1 -doMaf 1 -doGeno 32 -out $1_reads.testLD -isSim 1 -minMaf 0.03

#Unzip output files
gunzip -f $1_reads.testLD.geno.gz

########################################################################
# RUN ngsLD                                                            #
########################################################################
#Create position file
zcat $1_reads.testLD.mafs.gz | cut -f 1,2 | tail -n +2 > $1_pos.txt
NS=`cat $1_pos.txt | wc -l` 

MINMAF=$(echo "scale=2; 1/$N_SAM" | bc)

#Run ngsLD
/usr/bin/ngsLD --verbose 1 --n_ind $N_IND --n_sites $NS --geno $1_reads.testLD.geno --probs --pos $1_pos.txt --max_kb_dist 10 --min_maf £MINMAF --rnd_sample 0.05 > $1_reads.testLD.ld

########################################################################
# RETURN INPUT PARAMETERS                                              #
########################################################################

echo "SUMMARY OF PARAMETERS:" > $1_PARAMETERS.txt
	echo >> $1_PARAMETERS.txt
	echo "Number of Chromosomes="$N_SAM >> $1_PARAMETERS.txt
	echo "Number of Repetitions="$N_REPS >> $1_PARAMETERS.txt
	echo "Number of Individuals="$N_IND  >> $1_PARAMETERS.txt
	echo "THETA="$THETA "RHO="$RHO >> $1_PARAMETERS.txt 
	echo "Number of Sites="$N_SITES >> $1_PARAMETERS.txt
	echo "Sequencing Depth="$SEQ_DEPTH >> $1_PARAMETERS.txt
	echo "Error Rate="$ERR_RATE  >> $1_PARAMETERS.txt
	echo "Number of Result Sites="$NS >> $1_PARAMETERS.txt
if [ $# = 8 ]
then
	echo "Exponential Growth Rate="$EXPAND_RATE >> $1_PARAMETERS.txt 
elif [ $# = 9 ]
then
	echo "Coalescent Generations Since Bottleneck="$BOTTLE_GEN >> $1_PARAMETERS.txt
	echo "Fraction of Population Left After Bottleneck="$BOTTLE_SIZE >> $1_PARAMETERS.txt
fi


