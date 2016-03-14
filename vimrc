set nocompatible              " be iMproved, required
" set tabstop=4
" set shiftwidth=4
set expandtab " insert spaces when hitting TABs
" set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set autoindent
set cursorline
let &colorcolumn=join(range(99,999),",")
syntax on
set number
set foldmethod=indent
set foldlevel=99
set backspace=2
set nostartofline
set incsearch
set hlsearch
set clipboard+=unnamed
set t_Co=256
set tags=src/helios/tags;
let mapleader = ","
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
" Enable CursorLine
" Remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Python related bundles"
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/The-NERD-tree'
Bundle 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'benmills/vimux'
Plugin 'kchmck/vim-coffee-script'
Plugin 'craigemery/vim-autotag'
Plugin 'dkprice/vim-easygrep'
Plugin 'digitaltoad/vim-pug'
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"Ensures that syntastic works on demand
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': []}
let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_always_populate_loc_list=1
nnoremap <Leader>sc :SyntasticCheck<cr>

let g:NERDTreeMapHelp = '<F1>'
let g:EasyGrepRoot="repository"
let g:netrw_liststyle=3


fun! Quiet(cmd)
  try | exe a:cmd | catch | endtry
endfun
com! -nargs=1 Quiet :call Quiet(<args>)

fun! VimuxInspect()
  if exists('g:VimuxRunnerIndex')
    VimuxInspectRunner
  else
    echo 'No tmux runner to inspect'
  endif
endfun

fun! Preserve(command)
    let _s=@/
    let l=line(".")
    let c=col(".")
    execute a:command
    let @/=_s
    call cursor(l, c)
endfun

cnoremap %% <c-r>=expand('%:p')<cr>

" vimux mappings starting with <leader>r (r)un
noremap  <leader>rc :VimuxClearRunnerHistory<cr>
noremap  <silent><leader>ri :call VimuxInspect()<cr>
nmap     <leader>rl :call Preserve('normal V<leader>rs')<cr>
noremap  <leader>ro :call VimuxOpenRunner()<cr>
noremap  <leader>rp :VimuxPromptCommand<cr>
noremap  <leader>rq :call VimuxCloseRunner()<cr>
nnoremap <leader>rr :up!<cr>:Quiet('VimuxRunLastCommand')<cr>
nnoremap <C-g> :NERDTree<CR>

vmap     <leader>rs :call VimuxSlime()<cr>
nmap     <leader>rs :call Preserve('normal vip<leader>rs')<cr>
nmap     <leader>rS :call Preserve('normal ggVG<leader>rs')<cr>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR
map <Enter> o<ESC>
map <S-Enter> O<ESC>

if has("mouse")
    set mouse=a
endif
" Isort command to check imports"
command! -range=% Isort :<line1>,<line2>! isort -
" Status Line
set showcmd
set ruler " Show ruler
set laststatus=2 "show the statusline, even with just one file open

if has("statusline")
    set statusline=%<%F\%{exists('g:loaded_fugitive')?fugitive#statusline():''}%h%m%r%=%k[%{(&fenc\==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}][U+%04B]\ %-12.(%l,%c%V%)\ %P
endif
colors jellybeans
hi CursorLine term=bold cterm=bold,underline
