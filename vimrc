" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!mkdir -p ~/.vim/autoload'
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/d1c19a6fa934d90718c18e40acbec0ad7014e931/plug.vim'
endif

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set colorcolumn=80

let g:typescript_indent_disable = 1

call plug#begin('~/.vim/plugged')
Plug 'leafgarland/typescript-vim'
call plug#end()

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 30

set runtimepath^=/stack/src/main/experimental/users/nathan/.vim/bundle/ctrlp.vim
set runtimepath+=/stack/src/main/experimental/users/nathan/.vim/after

" This disables annoying indent problems in TypeScript. Doing this may have
" undesirable side effects for other file types. The problem with TypeScript
" was that going to normal mode, then back to insert mode, deleting the `{`
" after the `constructor()` below, and retyping it.
"
"     export class Foo {
"       constructor() {
"       }
"     }
set nocindent
set noautoindent
set indentexpr=
filetype indent off
filetype plugin indent off

" Indent on new line within brackets
set smartindent

" Remove trailing space on save:
autocmd FileType vimrc,js,ts,tempo,py,sh \
    autocmd BufWritePre <buffer> %s/\s\+$//e

let g:indentLine_char = '┊'
" let g:indentLine_char = '·'
let g:indentLine_color_term = 4

set relativenumber

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
nnoremap <F12>     :ShowSpaces 1<CR>
autocmd BufWritePre * %s/\s\+$//e
