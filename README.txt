Repository for LD MiniProject (Linked to github)
Did this really work?
Just checking one more time


TABLE OF CONTENTS:
├── Calc2.sh - A pipeline for simulating two populations at once
├── Calculate_StringInput.sh - A pipeline for simulating a single population from input variables including demographic rates
├── Graphing.R - R code to graph the LD parameter r^2 vs distance. Need to find a way to do this that doesn't require the results be in a specific folder relative to this script. 
├── README.txt
└── SandBox - For earlier versions of pieces of code that I'm temporarily saving
    ├── Calculate2_StringInput.sh - Version of calc2 that attempted to split the populations after generation. Calc2 uses angsd to seperate before generating sequences.
    ├── Example_Commands.txt - Commands to try 
    ├── ms_Test - Initial work with ms
    │   ├── ms_Test_01.sh
    │   └── readme.txt
    ├── ngsSim_SinglePop - Initial exploration of ngsSim
    │   └── ngsSim_Tests.sh
    ├── PipeLine_ms_ANGSD_ngsLD.sh - Simulates sequences under specified conditions and reports LD statistics for a constant, expanding, and contractin population. Uses ms, ANGSD, and ngsLD. Completed on 16 Jan in Collaboration with Matteo.
    ├── Ref_Seq.sh - Used to generate the ref sequence for angsd to use
    └── Testing_Bash_Input - Initial explorations of using input variables
        ├── Calculate.sh
        ├── Calculate_StringInput.sh
        └── Graphing.R

