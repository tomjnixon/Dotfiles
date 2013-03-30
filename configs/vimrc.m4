CONFIG_FILE(vim, ~/.vimrc)

set nocompatible
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
syntax on
filetype plugin indent on

set mouse=a

" Whitespace
set listchars=tab:⌞\ ,trail:⋅
set noexpandtab
set copyindent
set preserveindent
set list
set shiftwidth=2
set tabstop=2

set spelllang=en_gb

" Looks
set relativenumber
set guifont=IF_COMPUTER(MINE, Terminus\ 7, Monaco\ 8)
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

define(VIM_MODULE, `GIT_REPO(~/.vim/bundle/$1, $2)')
define(PROTO, IF_COMPUTER(LAPTOP, https, git))

VIM_MODULE(pathogen      , PROTO://github.com/tpope/vim-pathogen.git)
VIM_MODULE(fugitive      , PROTO://github.com/tpope/vim-fugitive.git)
VIM_MODULE(ctrlp         , PROTO://github.com/kien/ctrlp.vim.git)
VIM_MODULE(jellybeans    , PROTO://github.com/nanotech/jellybeans.vim.git)
VIM_MODULE(surround      , PROTO://github.com/tpope/vim-surround.git)
VIM_MODULE(gundo         , PROTO://github.com/vim-scripts/Gundo.git)
VIM_MODULE(ack           , PROTO://github.com/mileszs/ack.vim.git)
VIM_MODULE(gist          , PROTO://github.com/vim-scripts/Gist.vim.git)
VIM_MODULE(align         , PROTO://github.com/tsaleh/vim-align.git)
VIM_MODULE(markdown      , PROTO://github.com/tpope/vim-markdown.git)
VIM_MODULE(repeat        , PROTO://github.com/tpope/vim-repeat.git)
VIM_MODULE(unimpared     , PROTO://github.com/tpope/vim-unimpaired.git)
VIM_MODULE(conque        , PROTO://github.com/rosenfeld/conque-term.git)
VIM_MODULE(indent-object , PROTO://github.com/michaeljsmith/vim-indent-object.git)
VIM_MODULE(coffee-script , PROTO://github.com/kchmck/vim-coffee-script.git)
VIM_MODULE(rename        , PROTO://github.com/danro/rename.vim.git)
VIM_MODULE(easymotion    , PROTO://github.com/Lokaltog/vim-easymotion.git)
VIM_MODULE(n3            , PROTO://github.com/vim-scripts/n3.vim.git)
