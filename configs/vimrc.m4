CONFIG_FILE(vim, ~/.vimrc.local)

set mouse=a
colorscheme jellybeans+
" colorscheme vividchalk

set listchars=tab:⌞\ ,trail:⋅

set noexpandtab
set copyindent
set preserveindent
set relativenumber

set spelllang=en_gb

set guifont=Monaco\ 8
set guioptions-=T
set guioptions-=m

ON_COMPUTER(UNI)
set t_Co=256
END_COMPUTER()

nnoremap <F5> :GundoToggle<CR>

let g:SuperTabCrMapping=0
inoremap <CR> <CR>a<BS>
nnoremap o o<Space><BS>
nnoremap O O<Space><BS>

set hidden

" Stop surround.vim remapping s in visual mode.
xnoremap s s

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q

cmap w!! w !sudo tee % >/dev/null
