#!/bin/sh
#
# Script to prepare final PDFs for presentation and print.
#
# Usage sh build.sh <lectureNumberAsString>

fileprefix="TheoLog2017-Vorlesung-" # the start of generated PDFs
tmpfilename="tmplecturefile" # don't have any files called like this!

printfilename=$fileprefix$1-print.pdf
overlayfilename=$fileprefix$1-overlay.pdf

echo "\documentclass[onlymath,handout]{beamer}\n" > $tmpfilename.tex
tail -n +3 lecture-$1.tex >> $tmpfilename.tex
pdflatex $tmpfilename.tex
pdflatex $tmpfilename.tex
pdfnup --nup 2x2 --outfile $printfilename $tmpfilename.pdf

echo "\documentclass[onlymath]{beamer}\n" > $tmpfilename.tex
tail -n +3 lecture-$1.tex >> $tmpfilename.tex
pdflatex $tmpfilename.tex
pdflatex $tmpfilename.tex
mv $tmpfilename.pdf $overlayfilename

rm $tmpfilename.*

echo "\n\n*** Finished creating files '$overlayfilename' and '$printfilename' ***\n"
