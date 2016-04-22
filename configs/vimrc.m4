CONFIG_FILE(vim, ~/.vimrc)

GIT_REPO(~/.vim/bundle/Vundle.vim, https://github.com/gmarik/Vundle.vim.git)

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive.git'
Plugin 'ctrlpvim/ctrlp.vim.git'
Plugin 'nanotech/jellybeans.vim.git'
Plugin 'tpope/vim-surround.git'
Plugin 'sjl/gundo.vim.git'
Plugin 'mileszs/ack.vim.git'
Plugin 'vim-scripts/Gist.vim.git'
Plugin 'junegunn/vim-easy-align.git'
Plugin 'tpope/vim-markdown.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'michaeljsmith/vim-indent-object.git'
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'danro/rename.vim.git'
Plugin 'Lokaltog/vim-easymotion.git'
Plugin 'vim-scripts/n3.vim.git'
Plugin 'davidhalter/jedi-vim.git'
Plugin 'Rip-Rip/clang_complete.git'
Plugin 'ervandew/supertab.git'
Plugin 'vim-scripts/openscad.vim'
Plugin 'jez/vim-ispc.git'
Plugin 'vim-erlang/vim-erlang-omnicomplete'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'nvie/vim-flake8'

call vundle#end()
" configure jedi
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#smart_auto_mappings = 0

" configure supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let b:SuperTabNoCompleteAfter=['^ *']

" configure EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" configure table mode; rename lots of keys so they don't clash with ctrlp
" (mapped to <Leader>t)
let g:table_mode_map_prefix = '<Leader>a'
let g:table_mode_realign_map = '<Leader>ar'
let g:table_mode_delete_row_map = '<Leader>add'
let g:table_mode_delete_column_map = '<Leader>adc'
let g:table_mode_add_formula_map = '<Leader>afa'
let g:table_mode_eval_formula_map = '<Leader>afe'
let g:table_mode_echo_cell_map = '<Leader>a?'
let g:table_mode_sort_map = '<Leader>as'
" pandoc tables.
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="

set mouse=a

" Whitespace
set expandtab
set list
set shiftwidth=4
set tabstop=4

set spelllang=en_gb

" Looks
set relativenumber
set guifont=Terminus\ 8
set guioptions-=T
set guioptions-=m
set guioptions-=e " GTK tabs are less functional and take up more room.
colorscheme jellybeans
set showcmd
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set wildignore+=*.so,*.swp,*~
set wildmode=longest,list " readline sytle completion
let g:ctrlp_dotfiles = 0
let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git/', 'cd %s && git ls-files -c -o --exclude-standard'],
	\ }
	\ }


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
map <Leader>xx :silent ! chmod +x %<CR>
map <Leader>xp ggO#!/usr/bin/env python2<esc>\x
map <Leader>xb ggO#!/bin/bash<esc>\x
map <Leader>w :set wrap linebreak nolist<CR>

" probably my most common typo
command W w

" Speed up buffer switching
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-l> <C-W>l

set hidden

" Stop surround.vim remapping s in visual mode.
xnoremap s s

cmap w!! w !sudo tee % >/dev/null

" Align remaps a load of stuff begining with \t, which maked \t slow.
let g:loaded_AlignMapsPlugin = 1

au BufReadPre,BufNewFile SConstruct,SConscript set ft=python

au FileType c,cpp setlocal sw=2 ts=2 cinoptions=g0,i2
" recognise doxygen comments
au FileType c,cpp setlocal comments^=:///

au FileType tex let b:surround_109 = "\\(\r\\)"
au FileType tex let b:surround_77 = "\\[\r\\]"

" recognise '#. ' lists for pandoc markdown
au FileType markdown set flp+=\\\\|^#.\\s\\+

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

if filereadable(".vim.custom")
    so .vim.custom
endif
