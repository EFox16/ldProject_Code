#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: PipeLine_ms_ANGSD_ngsLD.sh
# Desc: Pipeline using ms to simulate, ANGSD to transform the files, and ngsLD to analyze 
# Arguments: Number of samples, number of reps, theta, rho, number of sites, sequencing depth, error rate, number of individuals, number of sites in transformed files
# Date: 16 JAN 2017

########################################################################
# 1 CONSTANT POPULATION SIZE                                           #
########################################################################

######
# ms #
######

#Parameters from Matteo
N_SAM=20
N_REPS=1

#THETA=$((4 * Ne * mu * $N_SITES))
THETA=600
RHO=$THETA
N_SITES=750000


#20 chromosomes/nsam=number of copies of the locus in each sample
#1 time (generations?)/nreps=number of independent samples
#-t is number of mutations
#-r is recombination rate
#number of sites to simulate

#Run ms to get simulated variable sites
/usr/bin/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES > constant.txt
 
#########
# ANGSD #
#########
SEQ_DEPTH=5
ERR_RATE=0.01 
N_IND=$((N_SAM / 2))
#Number of individuals is half of nsam (diploid organisms assumed)

#regLen is length of sequence. 
#can vary depth
#Err is error rate and just usually use 0.01
#N_Ind is number of samples which will be number of individuals x2
#might only need when using depth file option


#Convert to glf
/usr/bin/msToGlf -in constant.txt -out constant_reads -regLen $N_SITES -singleOut 1 -depth $SEQ_DEPTH -err $ERR_RATE -pileup 0 -Nsites 0

#Need to create fasta file
Rscript -e 'cat(">reference\n",paste(rep("A",1e6),sep="", collapse=""),"\n",sep="")' > reference.fa 

#creates reference file to avoid having to reference from beginning each time
samtools faidx reference.fa #should give reference.fa.fai

#Gives full sequence 
/usr/bin/angsd -glf constant_reads.glf.gz -fai reference.fa.fai -nInd $N_IND -doMajorMinor 1 -doPost 1 -doMaf 1 -doGeno 32 -out constant_reads.testLD -isSim 1 -minMaf 0.03

#Unzip output files
gunzip -f constant_reads.testLD.geno.gz
#CHECK LENGTH AT THIS POINT

#########
# ngsLD #
#########

#Create position file
zcat constant_reads.testLD.mafs.gz | cut -f 1,2 | tail -n +2 > constant_pos.txt
NS=`cat constant_pos.txt | wc -l` 

#Run ngsLD
/usr/bin/ngsLD --verbose 1 --n_ind $N_IND --n_sites $NS --geno constant_reads.testLD.geno --probs --pos constant_pos.txt --max_kb_dist 10 --min_maf 0.05 --rnd_sample 0.05 > constant_reads.testLD.ld

#Return input parameters
echo "VALUE OF SET PARAMETERS:"
echo "N_SAM" $N_SAM "N_REPS" $N_REPS "THETA" $THETA "RHO" $RHO "N_SITES" $N_SITES "SEQ_DEPTH" $SEQ_DEPTH "ERR_RATE" $ERR_RATE "N_IND" $N_IND "NS" $NS




########################################################################
# 2 EXPANDING POPULATION                                               #
########################################################################

######
# ms #
######

#~ N_SAM=20
#~ N_REPS=1

#~ THETA=600
#~ RHO=$THETA
#~ N_SITES=750000
 
TIME_AGO=0.3 # =T/(4*$N0) 
EXPAND_RATE=0.3 #((-ln($NT/$N0)/$TIME_AGO)) 

#Run ms to get simulated variable sites
../Thesis/Packages/msdir/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES -G EXPAND_RATE > expanding.txt
 
#########
# ANGSD #
#########
#~ SEQ_DEPTH=5
#~ ERR_RATE=0.01 
#~ N_IND=$((N_SAM / 2))

#Convert to glf
../Thesis/Packages/angsd/misc/msToGlf -in expanding.txt -out expanding_reads -regLen $N_SITES -singleOut 1 -depth $SEQ_DEPTH -err $ERR_RATE -pileup 0 -Nsites 0

#~ #Need to create fasta file
#~ Rscript -e 'cat(">reference\n",paste(rep("A",1e6),sep="", collapse=""),"\n",sep="")' > reference.fa 

#~ #creates reference file to avoid having to reference from beginning each time
#~ samtools faidx reference.fa #should give reference.fa.fai

#Gives full sequence 
../Thesis/Packages/angsd/angsd -glf expanding_reads.glf.gz -fai reference.fa.fai -nInd $N_IND -doMajorMinor 1 -doPost 1 -doMaf 1 -doGeno 32 -out expanding_reads.testLD -isSim 1 -minMaf 0.03

#Unzip output files
gunzip -f expanding_reads.testLD.geno.gz
#CHECK LENGTH AT THIS POINT

#########
# ngsLD #
#########

#Create position file
zcat expanding_reads.testLD.mafs.gz | cut -f 1,2 | tail -n +2 > expanding_pos.txt
C_NS=`cat expanding_pos.txt | wc -l` 

#Run ngsLD
../Thesis/Packages/ngsLD/ngsLD --verbose 1 --n_ind $N_IND --n_sites $C_NS --geno expanding_reads.testLD.geno --probs --pos expanding_pos.txt --max_kb_dist 10 --min_maf 0.05 --rnd_sample 0.05 > expanding_reads.testLD.ld

#Return input parameters
echo "VALUE OF SET PARAMETERS:"
echo "N_SAM" $N_SAM "N_REPS" $N_REPS "THETA" $THETA "RHO" $RHO "N_SITES" $N_SITES "SEQ_DEPTH" $SEQ_DEPTH "ERR_RATE" $ERR_RATE "N_IND" $N_IND "E_NS" $E_NS "EXPAND_RATE" $EXPAND_RATE




########################################################################
# 3 POPULATION BOTTLENECK                                              #
########################################################################

######
# ms #
######

#~ N_SAM=20
#~ N_REPS=1

#~ THETA=600
#~ RHO=$THETA
#~ N_SITES=750000

B_GEN=0.3
B_SIZE=0.5


#Run ms to get simulated variable sites
../Thesis/Packages/msdir/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES -eN $B_GEN $B_SIZE > bottleneck.txt
 
#########
# ANGSD #
#########
#~ SEQ_DEPTH=5
#~ ERR_RATE=0.01 
#~ N_IND=$((N_SAM / 2))

#Convert to glf
../Thesis/Packages/angsd/misc/msToGlf -in bottleneck.txt -out bottleneck_reads -regLen $N_SITES -singleOut 1 -depth $SEQ_DEPTH -err $ERR_RATE -pileup 0 -Nsites 0

#~ #Need to create fasta file
#~ Rscript -e 'cat(">reference\n",paste(rep("A",1e6),sep="", collapse=""),"\n",sep="")' > reference.fa 

#~ #creates reference file to avoid having to reference from beginning each time
#~ samtools faidx reference.fa #should give reference.fa.fai

#Gives full sequence 
../Thesis/Packages/angsd/angsd -glf bottleneck_reads.glf.gz -fai reference.fa.fai -nInd $N_IND -doMajorMinor 1 -doPost 1 -doMaf 1 -doGeno 32 -out bottleneck_reads.testLD -isSim 1 -minMaf 0.03

#Unzip output files
gunzip -f bottleneck_reads.testLD.geno.gz
#CHECK LENGTH AT THIS POINT

#########
# ngsLD #
#########

#Create position file
zcat bottleneck_reads.testLD.mafs.gz | cut -f 1,2 | tail -n +2 > bottleneck_pos.txt
B_NS=`cat bottleneck_pos.txt | wc -l` 

#Run ngsLD
../Thesis/Packages/ngsLD/ngsLD --verbose 1 --n_ind $N_IND --n_sites $B_NS --geno bottleneck_reads.testLD.geno --probs --pos bottleneck_pos.txt --max_kb_dist 10 --min_maf 0.05 --rnd_sample 0.05 > bottleneck_reads.testLD.ld

#Return input parameters
echo "VALUE OF SET PARAMETERS:"
echo "N_SAM" $N_SAM "N_REPS" $N_REPS "THETA" $THETA "RHO" $RHO "N_SITES" $N_SITES "SEQ_DEPTH" $SEQ_DEPTH "ERR_RATE" $ERR_RATE "N_IND" $N_IND "B_NS" $B_NS "B_GEN" $B_GEN "B_SIZE" $B_SIZE


