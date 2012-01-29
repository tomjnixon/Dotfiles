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
set guifont=Monaco\ 8
set guioptions-=T
set guioptions-=m
set guioptions-=e " GTK tabs are less functional and take up more room.
colorscheme jellybeans
set showcmd
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" Always show the status line (even if no split windows)
set laststatus=2


" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set wildignore+=*.so,*.swp,*~
let g:ctrlp_dotfiles = 0

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

" Turn on word wrapping.
command! -nargs=* Wrap set wrap linebreak nolist

au BufReadPre,BufNewFile SConstruct,SConscript set ft=python

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

VIM_MODULE(pathogen,     git://github.com/tpope/vim-pathogen.git)
VIM_MODULE(fugitive,     git://github.com/tpope/vim-fugitive.git)
VIM_MODULE(ctrlp,        git://github.com/kien/ctrlp.vim.git)
VIM_MODULE(jellybeans,   git://github.com/nanotech/jellybeans.vim.git)
VIM_MODULE(surround,     git://github.com/tpope/vim-surround.git)
VIM_MODULE(gundo,        git://github.com/vim-scripts/Gundo.git)
VIM_MODULE(ack,          git://github.com/mileszs/ack.vim.git)
VIM_MODULE(gist,         git://github.com/vim-scripts/Gist.vim.git)
VIM_MODULE(align,        git://github.com/tsaleh/vim-align.git)
VIM_MODULE(markdown,     git://github.com/tpope/vim-markdown.git)
VIM_MODULE(repeat,       git://github.com/tpope/vim-repeat.git)
VIM_MODULE(unimpared,    git://github.com/tpope/vim-unimpaired.git)
VIM_MODULE(conque,       git://github.com/rosenfeld/conque-term.git)
