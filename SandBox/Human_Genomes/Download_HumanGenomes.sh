#!/bin/bash

# download reference sequence
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz 
zcat human_g1k_v37.fasta.gz > ref.fa
bgzip ref.fa
samtools faidx ref.fa
rm human_g1k_v37.fasta.gz
