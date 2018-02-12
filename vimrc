" be iMproved, required
set nocompatible
" ------------------ Vundle Configuration ---------------
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set spelllang=en
set spell
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'kchmck/vim-coffee-script'
"Heuristic buffer setting
Plugin 'tpope/vim-sleuth'
" Syntax highlighting on jade files
 Plugin 'digitaltoad/vim-pug'
" Plugins for highlighting cjsx
Plugin 'mtscout6/vim-cjsx'
" Plugin to do regex folding
Plugin 'tmhedberg/SimpylFold'
" Plugin that uses ctags
Plugin 'vim-scripts/taglist.vim'
"PLugin to highlight special python syntax
Plugin 'vim-python/python-syntax'
"Trying an asynchronous linter"
Plugin 'w0rp/ale'
"Searching in vim
Plugin 'mileszs/ack.vim'
call vundle#end()            " required
"  ------------------Key Mapings--------------
filetype plugin indent on    " required
filetype plugin on
let mapleader = ","
" -------------------OmniCompletion on ---------------
function! UpdateTags()
  execute ":silent !ctags -R --languages=python"
  execute ":redraw!"
  echohl StatusLine | echo "Python tag updated" | echohl None
endfunction

noremap <Leader>c :call UpdateTags()
" ----------------Ale Configuration-----------
" Use project-specific Python linter config, if available
" Prevent linting on open file
let g:ale_lint_on_enter = 0
nnoremap <Leader>ll :ALELint<cr>
if filereadable("etc/pep8.cfg")
  let g:ale_python_flake8_options="--config=etc/pep8.cfg"
endif
if filereadable("etc/pylintrc")
  let g:ale_python_pylint_options="--rcfile=etc/pylintrc"
endif
" Format what errors look like with associated linters
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Mappings to move between errors
nmap <silent> <C-o> <Plug>(ale_previous_wrap)
nmap <silent> <C-p> <Plug>(ale_next_wrap)

" ----------------Syntastic Configuration----------
" Set colours to make color scheme work
set t_Co=256
colors jellybeans
"  Marks curosr line
" set cursorline
" Change column colour after 99
let &colorcolumn=join(range(80,999),",")
syntax on
" Ensure that numbers appear in a file
set number
"  Should not really use this as one ends up going into insert mode
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
