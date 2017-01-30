#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: Calculate2_StringInput.sh
# Desc: Pipeline using ms to simulate, ANGSD to transform the files, and ngsLD to analyze with command line argument inputs FOR A SIMULATION WITH MULTIPLE SUBPOPULATIONS
# Arguments: set name, number of samples, number of repetitions, theta, number of sites, sequencingdepth, error rate, AND exponential growth rate OR bottleneck time and magnitude 
# Date: 25 JAN 2017

########################################################################
# CREATE RESULTS FOLDER with reference sequence                        #
########################################################################

mkdir $1_Results
cd $1_Results

#Need to create fasta file
Rscript -e 'cat(">reference\n",paste(rep("A",1e7),sep="", collapse=""),"\n",sep="")' > reference.fa 

#creates reference file to avoid having to reference from beginning each time
samtools faidx reference.fa #should give reference.fa.fai

########################################################################
# SETTING VARIABLES                                                    #
########################################################################

SET_NAME=$1
N_SAM_S1=$2
N_IND_S1=$((N_SAM_S1 / 2))
N_SAM_S2=$3
N_IND_S2=$((N_SAM_S2 / 2))
N_SAM=$((N_SAM_S1+N_SAM_S2))
N_IND=$((N_SAM / 2))
N_REPS=$4 
THETA=$5
RHO=$THETA
N_SITES=$6 
SEQ_DEPTH=$7 
ERR_RATE=$8
SIMULATION_EVENTS=$9
MINMAF=$(echo "scale=2; 1/$N_SAM" | bc)

########################################################################
# RUN MS                                                               #
########################################################################

/usr/bin/ms $N_SAM $N_REPS -t $THETA -r $RHO $N_SITES -I 2 $N_SAM_S1 $N_SAM_S2 $SIMULATION_EVENTS > $1.txt

########################################################################
# SPLIT THE SUBPOPS                                                    #
########################################################################

#Copy the header
sed -n -e "1,6 p" -e "6 q" $1.txt > Sub1.txt
sed -n -e "1,6 p" -e "6 q" $1.txt > Sub2.txt

#Add in data
sed -n -e "7,$((6+N_SAM_S1)) p" -e "$((6+N_SAM_S1)) q" $1.txt >> Sub1.txt
sed -n -e "$((7+N_SAM_S1)), $((6+N_SAM_S1+N_SAM_S2)) p" -e "$((6+N_SAM_S1+N_SAM_S2)) q" $1.txt >> Sub2.txt


for SubFile in Sub1.txt Sub2.txt
do 	
	SubName=${SubFile%%.*}	
	counter=1
#Set the number of individuals
	if [ $SubName = "Sub1" ]
	then  
		SubPop_Size=$N_IND_S1
	elif [ $SubName = "Sub2" ]
	then
		SubPop_Size=$N_IND_S2
	fi

	echo $SubName
	echo $SubPop_Size

########################################################################
# CONVERT WITH ANGSD                                                   #
########################################################################

#~ #Convert to glf
	#~ /usr/bin/msToGlf -in $SubName.txt -out $SubName.reads -regLen $N_SITES -singleOut 1 -depth $SEQ_DEPTH -err $ERR_RATE -pileup 0 -Nsites 0 

done

#~ #Gives full sequence 
	#~ /usr/bin/angsd -glf $SubName.reads.glf.gz -fai reference.fa.fai -nInd $N_IND -doMajorMinor 1 -doPost 1 -doMaf 1 -doGeno 32 -out $SubName.reads.testLD -isSim 1 -minMaf $MINMAF

#~ #Unzip output files
	#~ gunzip -f $SubName.reads.testLD.geno.gz

#~ ########################################################################
#~ # RUN ngsLD                                                            #
#~ ########################################################################
#~ #Create position file
	#~ zcat $SubName.reads.testLD.mafs.gz | cut -f 1,2 | tail -n +2 > $SubName.pos.txt
	#~ NS=`cat $SubName.pos.txt | wc -l` 


#~ #Run ngsLD
	#~ /usr/bin/ngsLD --verbose 1 --n_ind $N_IND --n_sites $NS --geno $SubName.reads.testLD.geno --probs --pos $SubName.pos.txt --max_kb_dist 10 --min_maf $MINMAF --rnd_sample 0.05 > $SubName.reads.testLD.ld

#~ done

#~ ########################################################################
#~ # RETURN INPUT PARAMETERS                                              #
#~ ########################################################################

#~ echo "SUMMARY OF PARAMETERS:" > $1_PARAMETERS.txt
	#~ echo >> $1_PARAMETERS.txt
	#~ echo "Number of Chromosomes in SubPop 1="$N_SAM_S1 >> $1_PARAMETERS.txt
	#~ echo "Number of Chromosomes in SubPop 2="$N_SAM_S2 >> $1_PARAMETERS.txt
	#~ echo "Number of Repetitions="$N_REPS >> $1_PARAMETERS.txt
	#~ echo "Number of Individuals="$N_IND  >> $1_PARAMETERS.txt
	#~ echo "THETA="$THETA "RHO="$RHO >> $1_PARAMETERS.txt 
	#~ echo "Number of Sites="$N_SITES >> $1_PARAMETERS.txt
	#~ echo "Sequencing Depth="$SEQ_DEPTH >> $1_PARAMETERS.txt
	#~ echo "Error Rate="$ERR_RATE  >> $1_PARAMETERS.txt
	#~ echo "Number of Result Sites="$NS >> $1_PARAMETERS.txt
	#~ echo "Simulation Events="$SIMULATION_EVENTS >> $1_PARAMETERS.txt


