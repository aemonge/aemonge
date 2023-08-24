" syntax match quartoPythonCodeDelimiter /```{.*}/ conceal
" syntax match quartoPythonCodeStart /```{python}/ containedin=quartoPythonCode contains=quartoPythonCodeDelimiter
"
" highlight link quartoPythonCodeDelimiter Conceal
"
" runtime! syntax/markdown.vim
" let s:cs_safe = b:current_syntax
"
" unlet b:current_syntax
" syntax include @Python syntax/python.vim
" let b:current_syntax = s:cs_safe
"
" syntax region quartoPythonCode start=/```{python}/ end=/```/ contains=@Python
