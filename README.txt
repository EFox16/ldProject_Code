Repository for LD MiniProject (Linked to github)

#####################################################################
# DEPENDENCIES													    #
#####################################################################
Shell Scripting
***Within the project repository, create a folder called "Packages" on the
same level as Code and SandBox***
Download and install both ANGSD and htslib following the directions here:
	https://github.com/ANGSD/angsd
Download and install ms from this link:
	https://uchicago.app.box.com/s/l3e5uf13tikfjm7e1il1eujitlsjdx13
	Instructions can be found in the msdoc.pdf
Download and install samtools from this link:
	http://www.htslib.org/download/
Download the ngsLD zip file attached to the email. Extract it into the 
packages folder, cd into the new ngsLD folder, and run the command "make"


Your packages folder should now contain files called "angsd", "htslib", "msdir", 
"samtools-1.3.1", and "ngsLD"
Paths to these packages (specifically those in run_Simulation.sh) have been 
set up as relative paths from the Code folder to the location of the desired 
function in the packages folder.

R
require(ggplot2)
require(tools)
require(gridExtra)
require(grid)
require(reshape2)

Python
import sys
from lmfit import minimize, Minimizer, Parameters, Parameter, report_fit, fit_report
import numpy as np
import os
import csv

#####################################################################
# DATA FILES                                                        #
#####################################################################
Create a "Data" folder on the same level as Code and SandBox.
Put LWK.ld.gz and TSI.ld.gz in this folder. There is no need to extract them,
there is a line in run_MiniProject.sh that will unzip them and run the code.


####################################################################
# TABLE OF CONTENTS:									           #
####################################################################
├── Code
│   ├── Bin_ReadData.R - Breaks up .ld files into bins by length of successive 50 base pairs 
│   ├── Comparing_Curves.R - Plots a graph for the report that compares the best fit model of all 5 data sets
│   ├── CompileLaTeX.sh - Compiles the LaTeX file report and places it in results
│   ├── EmmaFox_Report.bib - Bibtex list for LaTeX report code
│   ├── EmmaFox_Report.tex - LaTeX code file for report submission
│   ├── Fit_5Models.py - Fits parameters from five models (exponential decay, gamma, linear, quadratic, cubic) to _Bin.csv files.
│   ├── Graphing_5FittedModels.R - Graphs the 5 model curves onto the _Bin.csv data using the parameters fit with the python script
│   ├── Graphing_ReportFigures.R - Graphs a grid of 5 plots which each shows one model curve overlain on the data with the accompanying aic value
│   ├── run_DataAnalysis.sh - Runs the binning, fitting, and graphing steps on the real data
│   ├── run_MiniProject.sh - Runs both run_DataAnalysis.sh and run_Simulation.sh for the specified data files and simulation conditions, respectively. 
│   └── run_Simulation.sh - Runs the simulations, binning, fitting, and graphing for hypothetical data sets.
├── Data
│   ├── LWK.ld.gz
│   └── TSI.ld.gz
├── README.txt
├── Results
│   └──Fitted_Graphs
│       ├── BestAIC.txt - Lists the best model for each data set and the accompanying AIC value
│       ├── Bottleneck_Bin_FitParams_ModelPlot.jpg - All 5 fitted curves overlaid on one plot
│       ├── Bottleneck_Bin_FitParams_ReportFigure.pdf - Figure for report with each curve plotted seperately
│       ├── Comparison_ModelPlot.pdf - Plot of the best fit curve for each data set all overlaid on the same plot
│       ├── Constant_Bin_FitParams_ModelPlot.jpg - All 5 fitted curves overlaid on one plot
│       ├── Constant_Bin_FitParams_ReportFigure.pdf - Figure for report with each curve plotted seperately
│       ├── Expand_Bin_FitParams_ModelPlot.jpg - All 5 fitted curves overlaid on one plot
│       ├── Expand_Bin_FitParams_ReportFigure.pdf - Figure for report with each curve plotted seperately
│       ├── LWK_Bin_FitParams_ModelPlot.jpg - All 5 fitted curves overlaid on one plot
│       ├── LWK_Bin_FitParams_ReportFigure.pdf - Figure for report with each curve plotted seperately
│       ├── TSI_Bin_FitParams_ModelPlot.jpg - All 5 fitted curves overlaid on one plot
│       └── TSI_Bin_FitParams_ReportFigure.pdf - Figure for report with each curve plotted seperately
└── SandBox
    ├── Curve_Fitting
    │   ├── 01_lmfit.py - One lmfit online tutorial
    │   ├── 02_lmfit.py - Another lmfit online tutorial
    │   ├── 03_lmfitFreehand_ExponentialDecay.py - Trying an ideal exponential fit on my own
    │   ├── 04_lmfitFreehand_Polynomial.py - Trying an ideal polyomial fit on my own
    │   ├── 05_lmfitFreehand_Gamma.py - Tryig an ideal gamm fit on my own
    │   ├── Fit_Exponential.py - Exponential fitting script for .ld files
    │   ├── Fit_Gamma.py - Gamma fitting script for .ld files
    │   ├── Fit_Polynomial.py - Polynomial fitting script for .ld files
    ├── Draft_Pipelines
    │   ├── Calc2.sh - A pipeline for simulating two populations at once
    │   ├── Fit_3Models.py - Model fitting code for an exponential, gammma, and cubic model
    │   ├── Fit_ScaledPoly.py - Model fitting code for 7 polynomial models
    │   ├── Graphing_FittedModels.R - Graphing script for the 7 polynomial models
    │   ├── Graphing.R - Graphing script for raw .ld data
    │   ├── ms_Test_01.sh - Initial ms tutorial work
    │   ├── PipeLine_ms_ANGSD_ngsLD.sh - Initial ms to angsd to ngsLD pipeline
    │   ├── Ref_Seq.sh - Creates the reference sequence for angsd
    ├── NamingArgFiles.sh - practice file for naming outputs using the input name
    └── Read_LD.py - practice reading in .ld files as numpy arrays
