#!/bin/bash

pdflatex resume.tex

rm resume.aux
rm resume.log
rm resume.out

mv resume.pdf www/python-tech-lead_andres-monge.pdf

