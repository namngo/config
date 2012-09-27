nnoremap / /\v
vnoremap / /\v

nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv
nnoremap <Up> <C-w>l
nnoremap <Down> <C-w>h

set relativenumber

set nocompatible
filetype on
set history=500
filetype plugin on
set lsp=0
set number
set cmdheight=2
set backspace=2

set listchars=tab:>-
set listchars+=trail:.

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

set ai
set si
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set smarttab

set foldenable
set foldmethod=syntax
set foldlevel=20

set scrolloff=8

syntax on
set background=dark

nmap <F5> :set invnumber <CR>

set pastetoggle=<F8>

set cindent
set smartindent
set autoindent
set expandtab

set t_Co=256
colo molokai

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML
au FileType javascript call JavaScriptFold()
