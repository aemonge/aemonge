#!/bin/bash

mv docs/avatar.png .
pdflatex resume.tex

rm resume.aux
rm resume.log
rm resume.out

mv resume.pdf docs/python-tech-lead_andres-monge.pdf
mv avatar.png docs/.
