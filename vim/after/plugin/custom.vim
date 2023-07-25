" This was an attempt to get vim to display spaces. I'm disabling it because
" there were multiple problems with it, including:
"
" - It currently only works on plain files. More modifications are needed to
"   make it work alongside files that have syntax highlighting.
" - It conflicts with other things I would want to do with conceal.
" - It causes quotes to be concealed in JSON files (since concealcursor is set
"   to i, meaning things are still concealed in insert mode, and the standard
"   JSON syntax highlighter hides quotes with conceallevel=2).

" set conceallevel=2
" set concealcursor=nci

" syn match IndentLineSpace /^\s\+/ containedin=ALL contains=IndentLine
" syn match IndentLine / \zs \ze/ contained conceal cchar=·
" syn match IndentLine /^ / contained conceal cchar=·
" hi Conceal ctermfg=blue
