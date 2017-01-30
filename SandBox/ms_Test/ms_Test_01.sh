#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: ms_Test_01.sh
# Desc: Exploration of ms with human like chromosome. 
# Arguments: none
# Date: 27 DEC 2016


#NOTES: Get rid of quotations


######
# ms ###################################################################
######

#Parameters from Matteo
N_SAM="20"
N_REPS="1"

THETA="600"
RHO=$THETA
N_SITES="1000000" 


#20 chromosomes/nsam=number of copies of the locus in each sample
#1 time (generations?)/nreps=number of independent samples
#-t is number of mutations
#-r is recombination rate
#number of sites to simulate

##CONSTANT POP SIZE##
../../../Thesis/Packages/msdir/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES > ms_constant.txt

#OR
#mspms 20 1 -t $THETA -r $RHO $N_SITES > ms_Test_01/ms_constant.txt
 
#~ ##EXPANDING POP##
#~ EXPAND_RATE="7"
#~ #Need a realistic scenario including PAST POP SIZE and HOW LONG AGO it occurred
#~ #Currently 2000 to 10000 in 40000 (0.1 4N0 generations)

#~ ../../../Thesis/Packages/msdir/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES -G $EXPAND_RATE  > ms_expanding.txt

#~ ##SHRINKING POP##
#~ SHRINK_RATE="-7"
#~ START_GENERATION="0.1"
#~ #Need to add a parameter that ensures there is some coalescence at some past point

#~ ../../../Thesis/Packages/msdir/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES -G $SHRINK_RATE -eG $START_GENERATION 0 > ms_shrinking.txt

#########
# ANGSD ################################################################
#########
SEQ_DEPTH="5"
ERR_RATE="0.01" 
N_SAM_2="10"
#Number of individuals is half of nsam (diploid organisms assumed)

#regLen is length of sequence. 
#can vary depth
#Err is error rate and just usually use 0.01
#N_Ind is number of samples which will be number of individuals x2
#might only need when using depth file option


##CONSTANT POP SIZE##
../../../Thesis/Packages/angsd/misc/msToGlf -in ms_constant.txt -out constant_reads -regLen $N_SITES -singleOut 1 -depth $SEQ_DEPTH -err $ERR_RATE -pileup 0 -Nsites 0

#Need to create fasta file
Rscript -e 'cat(">reference\n",paste(rep("A",1e6),sep="", collapse=""),"\n",sep="")' > reference.fa 

#creates reference file to avoid having to reference from beginning each time
samtools faidx reference.fa #should give reference.fa.fai

#Not creating the full sequence for some reason (under investigation)
../../../Thesis/Packages/angsd/angsd -glf constant_reads.glf.gz -fai reference.fa.fai -nInd 10 -doMajorMinor 1 -doPost 1 -doMaf 1 -doGeno 32 -out constant_reads.testLD -isSim 1 -minMaf 0.03

#Unzip output files
gunzip -f constant_reads.testLD.geno.gz
#CHECK LENGTH AT THIS POINT

########
# ngsLD ################################################################
########

#Create position file
zcat constant_reads.testLD.mafs.gz | cut -f 1,2 | tail -n +2 > pos.text
NS=`cat pos.text | wc -l` 

#ALWAYS REMEMBER TO REMOVE 1 FROM THE NUMEBR OF SITES
#Run ngsLD
../../../Thesis/Packages/ngsLD/ngsLD --verbose 1 --n_ind 10 --n_sites $NS --geno constant_reads.testLD.geno --probs --pos pos.text --max_kb_dist 10 --min_maf 0.05 --rnd_sample 0.05 > constant_reads.testLD.ld


#########################
# Calculating distances ################################################
#########################

#Open R for this bit
#res=read.table("constant_reads.testLD.ld", head=F, strignsAsFactors=F)

#pos = 1e6*as.numeric(strsplit(readLines("ms_constant.txt")[6], split=" ")[[1]][-1])

#need to go and calculate distances myself with snp 1 vs snp 2 etc
#eventually move to binary (do geno 32, must gunzip -f )
