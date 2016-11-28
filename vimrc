" be iMproved, required
set nocompatible
" ------------------ Vundle Configuration ---------------
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" All of your Plugins must be added before the following line
Plugin 'kchmck/vim-coffee-script'
" Linting across files
Plugin 'scrooloose/syntastic'
" Auto indent files based on file type
Plugin 'tpope/vim-sleuth'
" Syntax highlighting on jade files
 Plugin 'digitaltoad/vim-pug'
" Plugins for highlighting cjsx
Plugin 'mtscout6/vim-cjsx'
" Plugin to do regex folding
Plugin 'tmhedberg/SimpylFold'
" Plugin to indent python, special cases
Plugin 'vim-scripts/indentpython.vim'
" Auto completion with supertab
Plugin 'ervandew/supertab'
call vundle#end()            " required
filetype plugin indent on    " required
"  ------------------Vundle Configuration --------------
let mapleader = ","
" ----------------Syntastic Configuration-----------
"Ensures that syntastic works on demand
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [],'passive_filetypes': []}
let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_always_populate_loc_list=1
noremap <Leader>sc :SyntasticCheck<cr>
" ----------------Syntastic Configuration----------
" Set colours to make color scheme work
set t_Co=256
colors jellybeans
"  Marks curosr line
set cursorline
" Change column colour after 99
let &colorcolumn=join(range(99,999),",")
syntax on
" Ensure that numbers appear in a file
set number
" Should not really use this as one ends up going into insert mode
" set backspace=2
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
"--Searching
" Highlight searched text
set hlsearch
" Search as soon as typing starts
set incsearch
set tags=src/helios/tags;
" Setup clipboard so copy buffer is accessible outside vim
set clipboard+=unnamed
" Folding
set foldmethod=indent
set foldlevel=99
set mouse=a
" Isort command to check imports"
command! -range=% Isort :<line1>,<line2>! isort -
" ---------- Split Navigations
" Moving between vim split screens using
noremap <silent> ,F :let word=expand("<cword>")<CR>:vsp<CR>:exec("tjump ".expand("<cword>"))<CR>nnoremap <C-]> g<C-]>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" -----------Status Line ---------
" Status Line
set showcmd
set ruler " Show ruler
set laststatus=2 "show the statusline, even with just one file open

"set statusline=%t       "tail of the filename
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%h      "help file flag
"set statusline+=%m      "modified flag
"set statusline+=%r      "read only flag
"set statusline+=%y      "filetype
"set statusline+=%=      "left/right separator
"set statusline+=%c,     "cursor column
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file

if has("statusline")
	set statusline=%<%F\%{exists('g:loaded_fugitive')?fugitive#statusline():''}%h%m%r%=%k[%{(&fenc\==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}][U+%04B]\ %-12.(%l,%c%V%)\ %P
endif
" Remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e
" ------------Python Configuration------------------"
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=99 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
