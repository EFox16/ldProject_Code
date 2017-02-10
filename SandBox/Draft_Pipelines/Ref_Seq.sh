#!/bin/bash
# Author: Emma Fox e.fox16@imperial.ac.uk
# Script: Ref_Seq.sh
# Desc: Creates reference sequence for ANGSD
# Arguments: Length of desired sequence
# Date: 25 JAN 2017


#Need to create fasta file
Rscript -e 'cat(">reference\n",paste(rep("A",1e9),sep="", collapse=""),"\n",sep="")' > reference.fa 

#creates reference file to avoid having to reference from beginning each time
samtools faidx reference.fa #should give reference.fa.fai
