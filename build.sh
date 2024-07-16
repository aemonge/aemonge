#!/bin/bash

# Move avatar to root directory
mv docs/avatar.png .

# Compile LaTeX to PDF
pdflatex resume.tex

# Clean up auxiliary files
rm resume.aux resume.log resume.out

# Move PDF to docs folder
mv resume.pdf docs/python-tech-lead_andres-monge.pdf

# Move avatar back to docs folder
mv avatar.png docs/

# Generate README.md from resume.tex
sed -n '/\\begin{document}/,/\\end{document}/p' resume.tex |
sed -e 's/\\section{\([^}]*\)}/## \1/g' \
    -e 's/\\subsection{\([^}]*\)}/### \1/g' \
    -e 's/\\begin{itemize}//g' \
    -e 's/\\end{itemize}//g' \
    -e 's/\\item/- /g' \
    -e 's/\\textbf{\([^}]*\)}/**\1**/g' \
    -e 's/\\emph{\([^}]*\)}/*\1*/g' \
    -e 's/\\href{\([^}]*\)}{\([^}]*\)}/[\2](\1)/g' \
    -e 's/\\\\//g' \
    -e '/^\s*$/d' > README.md

# Add title to README.md
sed -i '1i# Andres Monge - Python Tech Lead Resume\n' README.md
