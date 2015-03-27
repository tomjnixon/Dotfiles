CONFIG_FILE(vim, ~/.vimrc)

GIT_REPO(~/.vim/bundle/Vundle.vim, https://github.com/gmarik/Vundle.vim.git)

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'nanotech/jellybeans.vim.git'
Plugin 'tpope/vim-surround.git'
Plugin 'vim-scripts/Gundo.git'
Plugin 'mileszs/ack.vim.git'
Plugin 'vim-scripts/Gist.vim.git'
Plugin 'tsaleh/vim-align.git'
Plugin 'tpope/vim-markdown.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'michaeljsmith/vim-indent-object.git'
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'danro/rename.vim.git'
Plugin 'Lokaltog/vim-easymotion.git'
Plugin 'vim-scripts/n3.vim.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'vim-scripts/openscad.vim'

call vundle#end()
filetype plugin indent on
syntax on

let g:bufferline_rotate=1
let g:ycm_server_keep_logfiles=1
let g:ycm_server_use_vim_stdout = 1

set mouse=a

" Whitespace
set listchars=tab:⌞\ ,trail:⋅
set expandtab
set copyindent
set preserveindent
set list
set shiftwidth=4
set tabstop=4
set smarttab

set spelllang=en_gb

" Looks
set relativenumber
set guifont=Terminus\ 7
set guioptions-=T
set guioptions-=m
set guioptions-=e " GTK tabs are less functional and take up more room.
colorscheme jellybeans
set showcmd
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" Always show the status line (even if no split windows)
set laststatus=2

" Make O work in a timely fashion.
set ttimeoutlen=100

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set wildignore+=*.so,*.swp,*~
let g:ctrlp_dotfiles = 0
let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git/', 'cd %s && git ls-files -c -o --exclude-standard'],
	\ }
	\ }


ON_COMPUTER(UNI)
set t_Co=256
END_COMPUTER()

map <Leader>sv :so $MYVIMRC<CR>
map <Leader>u :GundoToggle<CR>
map <Leader>t :CtrlP<CR>
map <Leader>b :CtrlPMRUFiles<CR>
map <Leader>h :noh<CR>
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gD :diffoff!<cr><c-w>h:bd<cr>
map <Leader>gs :Gstatus<CR>
map <Leader>gw :Gwrite<CR>
map <Leader>gr :Gread<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gp :Git push<CR>
map <Leader>ft :filetype detect<CR>
map <Leader>x :silent ! chmod +x %<CR>
map <Leader>bp ggO#!/usr/bin/env python2<esc>\x
map <Leader>bb ggO#!/bin/bash<esc>\x
map <Leader>w :set wrap linebreak nolist<CR>

" Speed up buffer switching
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-l> <C-W>l


" Fix removal of indents.
inoremap <CR> <CR><Space><BS>
nnoremap o o<Space><BS>
nnoremap O O<Space><BS>

set hidden

" Stop surround.vim remapping s in visual mode.
xnoremap s s

cmap w!! w !sudo tee % >/dev/null

" Align remaps a load of stuff begining with \t, which maked \t slow.
let g:loaded_AlignMapsPlugin = 1

au BufReadPre,BufNewFile SConstruct,SConscript set ft=python

au FileType tex let b:surround_109 = "\\(\r\\)"
au FileType tex let b:surround_77 = "\\[\r\\]"

" Enable backups and persistent undo.
set backup
set undofile
set undolevels=1000
set undoreload=10000

" Load and save view settings.
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview
au BufWinLeave * let b:winview = winsaveview()
au BufWinEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif

" Make directories for the above settings.
" Modified from spf13-vim.
function! InitializeDirectories()
	let separator = "."
	let parent = $HOME . "/.vim"
	let dir_list = {
				\ 'backup': 'backupdir',
				\ 'views': 'viewdir',
				\ 'swap': 'directory',
				\ 'undo': 'undodir' }
	
	for [dirname, settingname] in items(dir_list)
		let directory = parent . '/' . dirname . "/"
		if !isdirectory(directory)
			call mkdir(directory)
		endif
		let directory = substitute(directory, " ", "\\\\ ", "")
		exec "set " . settingname . "=" . directory
	endfor
endfunction
call InitializeDirectories()
