 " augroup filetypedetect
 "     au! BufRead,BufNewFile *.qmd setfiletype quarto
 " augroup END

 augroup filetypedetect
     au! BufRead,BufNewFile *.buffer setfiletype buffermd
 augroup END
