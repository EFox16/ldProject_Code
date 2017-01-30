readme for ms_Test_01

Pipeline consisting of:
ms
ANGSD
ngsLD

ms - generates three text files of data. one each for a population of constant size, an expanding population, and a shrinking population
inputs: N_SAM, N_Reps, THETA, RHO, N_SITES, EXPAND_RATE, SHRINK_RATE
files: output file prefixes

ANGSD - converts ms files to glf files that can be read by ngsLD
inputs: N_SITES, singleout, SEQ_DEPTH, ERR_RATE, N_SAM  
files: input file and output prefixes 

ngsLD - runs LD analysis on output files
inputs: pos, N_SAM, N_SITES
files: input file and output prefixes


