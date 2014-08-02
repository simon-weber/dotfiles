" other dependencies:
" * python
" * pypi: flake8, autopep8
" * ag

set nocompatible                " choose no compatibility with legacy vi
filetype off
filetype plugin indent off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

let gitdir=system("git rev-parse --show-toplevel")
if empty(gitdir)
    " not a git repo
    let gitdir = "."
else
    " remove \r\n
    let gitdir = gitdir[:-2]
endif

let pythoncmd = "python -c 'import os.path; print os.path.relpath(\"" . gitdir . "\")'"
let relgitdir = system(pythoncmd)[:-2]


Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'JavaScript-Indent'
Bundle 'hynek/vim-python-pep8-indent.git'
Bundle 'tpope/vim-markdown'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'

Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

Bundle 'python_match.vim'
"" % becomes python-aware
"" [% and ]% go to start/end of current block

Bundle 'scrooloose/syntastic'
let g:syntastic_python_checkers=['flake8', 'python']

Bundle 'davidhalter/jedi-vim'
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "right"

if bufname("%") =~? '\.spt$'
    let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
endif

if executable('ag')
    " The Silver Searcher
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif


filetype plugin indent on
syntax enable

let mapleader = ","

set encoding=utf-8
set showcmd                     " display incomplete commands
set undofile
set number
highlight LineNr ctermfg=darkcyan

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

" grep word under cursor
nnoremap <leader>l :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
execute "nnoremap <leader>f :silent lgrep! \"(\\b)<C-R><C-W>(\\b)\" " . relgitdir . "<CR>:lopen<CR>:redraw!<CR>"

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
execute "nnoremap \\ :Ag  " . relgitdir . "<C-Left><left>"

set hidden                      " allow leaving buffer with outstanding changes

" Splits
set splitbelow                  " splits open right and below
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" open line in quickfix window in new vertical split
autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

" show buffer list for faster switching
:nnoremap <leader>m :buffers<CR>:buffer<Space>
:nnoremap <leader>p :b#<CR>


"" Python-specific things
au BufEnter,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=100 smarttab expandtab
au FileType python setlocal formatprg=autopep8\ -

"" auto-remove trailing whitespace
"" autocmd BufWritePre *.py :%s/\s\+$//e

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

au BufRead *.spt set ft=python
