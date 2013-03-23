set nocompatible                " choose no compatibility with legacy vi
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'davidhalter/jedi-vim'
Bundle 'JavaScript-Indent'

let g:jedi#popup_on_dot = 0
let g:syntastic_python_checkers=['flake8', 'python']
let g:jedi#show_function_definition = "0"

"" set rtp+=$GOROOT/misc/vim    " when using GO

filetype plugin indent on       " for vundle

syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands

"" Whitespace
set nowrap                      
set tabstop=4 shiftwidth=4      
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital 


"" Python-specific things
au BufEnter,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=100 smarttab expandtab
autocmd BufWritePre *.py :%s/\s\+$//e  " auto-remove trailing whitespace

"" Emacs-style autoindent
set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
set indentkeys=!<Tab>,o,O
map <Tab> i<Tab><Esc>^
filetype indent on
set cinoptions=:0,(0,u0,W1s
autocmd FileType * setlocal indentkeys+=!<Tab>

"" Smooth scrolling (http://stackoverflow.com/questions/4064651)
noremap <expr> <C-u> repeat("\<C-y>", 20)
noremap <expr> <C-d> repeat("\<C-e>", 20)
set so=7
