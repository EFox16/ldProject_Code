#!/bin/bash
# Author: Samraat Pawar (modified by Emma Fox)
# Script: CompileLaTeX.sh
# Desc: Compiles a PDF file from a .tex and .bib files
# Arguments: Name of .tex file without extensions 
   
#~ if [ ! -f ../Results/$1.pdf ]
	#~ then
		#~ echo -e "\n"
	#~ else 
		#~ rm ../Results/$1.pdf # remove existing pdf
#~ fi


pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex

#Move file to the results folder
mv $1.pdf ../Results

#Now open pdf if file exists and is non-empty
if [ -s ../Results/$1.pdf ] 
then
	evince ../Results/$1.pdf &
else
	echo "$1.pdf is empty."
fi

## Cleanup
rm -f *~
rm -f *.aux
rm -f *.blg
rm -f *.log
rm -f *.nav
rm -f *.out
rm -f *.snm
rm -f *.toc
rm -f *.vrb
rm -f *.bbl
rm -f *.dvi
rm -f *.lot
rm -f *.lof
