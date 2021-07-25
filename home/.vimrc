" other dependencies:
" * python
" * pypi: flake8, autopep8
" * ag

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

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

Plugin 'tpope/vim-surround'
Plugin 'hynek/vim-python-pep8-indent.git'
Plugin 'tpope/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'fisadev/vim-isort'
Plugin 'rodjek/vim-puppet'
Plugin 'pangloss/vim-javascript'
Plugin 'LnL7/vim-nix'

Plugin 'python_match.vim'
"" % becomes python-aware
"" [% and ]% go to start/end of current block

Plugin 'scrooloose/syntastic'
let g:syntastic_python_checkers=['flake8', 'python']
let g:syntastic_javascript_checkers = ['eslint']

Plugin 'davidhalter/jedi-vim'
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#show_call_signatures = 0
let g:jedi#smart_auto_mappings = 0

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

call vundle#end()

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_use_caching = 0
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
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

" also close location list when quitting buffer
cabbrev q lcl\|q
" shortcut for closing location list
cabbrev ql lcl

function! MagicQuit()
    if &buftype == 'quickfix'
        " assumes quickfix isn't being used
        execute 'lclose'
    else
        execute 'quit'
    endif
endfunction

cabbrev q :call MagicQuit()

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

" zoom current buffer in a tab by itself
" https://stackoverflow.com/a/39562425
nnoremap <leader>z :call TabToggle()<CR>
function! TabToggle()
  if tabpagewinnr(tabpagenr(), '$') > 1
    " Zoom in when this tab has more than one window
    tab split
  elseif tabpagenr('$') > 1
    " Zoom out when this tab is not the last tab
    if tabpagenr() < tabpagenr('$')
      tabclose
      tabprevious
    else
      tabclose
    endif
  endif
endfunction

" folds
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

" tabs
set tabstop=2
set softtabstop=2 
set shiftwidth=2 

"" Python-specific things
au BufEnter,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=130 smarttab expandtab foldmethod=syntax
au FileType python setlocal formatprg=autopep8\ -

"" js-specific things
"" autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 textwidth=130 smarttab expandtab foldmethod=syntax
au BufEnter,BufRead *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2 smarttab expandtab foldmethod=indent

au BufRead,BufNewFile *.md set filetype=markdown
au BufEnter,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2 textwidth=130 smarttab expandtab foldmethod=syntax
au BufEnter,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2 smarttab expandtab foldmethod=syntax
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"" auto-remove trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e

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

"" Spell checking
"" autocmd BufRead,BufNewFile *.md setlocal spell
"" autocmd FileType gitcommit setlocal spell
