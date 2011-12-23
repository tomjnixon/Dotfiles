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

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set wildignore+=*.so,*.swp,*~


ON_COMPUTER(UNI)
set t_Co=256
END_COMPUTER()

map <Leader>sv :so $MYVIMRC<CR>
map <Leader>u :GundoToggle<CR>
map <Leader>t :CtrlP<CR>
map <Leader>b :CtrlPMRUFiles<CR>
map <Leader>h :noh<CR>
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

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
