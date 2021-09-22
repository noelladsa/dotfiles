" be iMproved, requiredv
set nocompatible


" ------------------ Vundle Configuration ---------------
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Vim solarized
Plugin 'altercation/vim-colors-solarized.git'
"Asynchronous linter"
Plugin 'w0rp/ale'
"PLugin to highlight special python syntax
Plugin 'vim-python/python-syntax'
"Python indentation after parenthesis
Plugin 'indentpython.vim'
"Search based on file contents
Plugin 'mileszs/ack.vim'
"earch based on file name
Plugin 'junegunn/fzf.vim'
"Git wrapper for vim
Plugin 'tpope/vim-fugitive'
"Highglight jade
Plugin 'digitaltoad/vim-pug'
" Auto close characters, paranthesis, brackets, quotes etc
Plugin 'townk/vim-autoclose'
" Readline bindings in vim
Plugin 'tpope/vim-rsi'
" Plugin to work with coffeescript
Plugin 'kchmck/vim-coffee-script'
"Jsx highlighting
Plugin 'mxw/vim-jsx'
" Add edit config plugin
Plugin 'editorconfig/editorconfig-vim'
" Add vinegar
Plugin 'tpope/vim-vinegar'
" Add black
Plugin 'psf/black'
call vundle#end()            " required
filetype plugin indent on
" --------------------- FZF configuration -----------------
" So fzf.vim knows where fzf is https://statico.github.io/vim3.html
" nmap ; :Buffers<CR>
" nmap <Leader>t :Files<CR>
" nmap <Leader>r :Tags<CR>
set rtp+=/usr/local/opt/fzf
" --------------- python-syntax Configuration -----
let mapleader = ","
" ----------------- sql formatter--------------
nnoremap <Leader>m :%!sqlfmt --tab-width 2 --use-spaces --print-width 78<cr>
" ----------------Ale Configuration-----------
" Use project-specific Python linter config, if available
" Prevent linting on open file
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'never'
nnoremap <Leader>ll :ALELint<cr>
nnoremap <Leader>ck :Black<cr>
if filereadable("etc/pep8.cfg")
  let g:ale_python_flake8_change_directory = 0
  let g:ale_python_flake8_options="--config=etc/pep8.cfg"
endif
if filereadable("etc/pylintrc")
  let g:ale_python_pylint_change_directory = 0
  let g:ale_python_pylint_options="--rcfile=etc/pylintrc"
endif
let g:ale_javascript_eslint_options="--rule 'no-unused-vars: off'"

" Format what errors look like with associated linters
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"let g:ale_fixers = {"javascript":[ 'prettier',  'eslint'], "python":["autopep8", "isort", "remove_trailing_lines"]}
if filereadable("etc/pep8.cfg")
  let g:ale_python_autopep8_options = '--global-config==etc/pep8.cfg'
endif
let g:ale_fix_on_save = 1
" -------------- Code Search ----------------
if executable('ag')
  let g:ackprg = 'ag -Q --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
nmap <M-k>    :Ack! "\b<cword>\b" <CR>
nmap <Esc>k   :Ack! "\b<cword>\b" <CR>

" --------------- File Search --------------
nnoremap <Leader>f :Files<Space><CR>
nnoremap <Leader>b :Buffers<Space><CR>
" ------------------ Miscellaneous configuration ---------------
" Ensure that numbers appear in a file
set number
" Setup clipboard so copy buffer is accessible outside vim
set clipboard+=unnamed
" Syntax highlighting
syntax on
set t_Co=256
set background=light
colorscheme solarized

" Change column colour after 99
"let &colorcolumn=join(range(80,999),",")
" Highlight searched text
set hlsearch
" Search as soon as typing starts
set incsearch
" Isort command to check imports"
command! -range=% Isort :<line1>,<line2>! isort -
" Remove trailing spaces before file is saved
autocmd BufWritePre * :%s/\s\+$//e
"" ------------Python Configuration------------------"
"au BufNewFile,BufRead Filetype python
"    \ set tabstop=4 |
"    \ set softtabstop=4 |
"    \ set shiftwidth=4 |
"    \ set textwidth=|
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix |
"
"" ------------- Pug file settings ------------------------"
"autocmd FileType pug
"    \ set tabstop=2 |
"    \ set softtabstop=2 |
"    \ set shiftwidth=2 |
"    \ set expandtab |


set laststatus=2 "show the statusline, even with just one file open
set statusline=%F       "tail of the filename
set statusline+=,%c,     "cursor column
"set statusline+=%=      "left/right separator
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set foldmethod=indent
set complete-=i
set hidden
setlocal spell
set tags^=./.git/tags;
" Postgresql edit buffer
au BufRead /tmp/psql.edit.* set syntax=sql
