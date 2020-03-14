CONFIG_FILE(vim, ~/.vimrc)

GIT_REPO(~/.vim/bundle/Vundle.vim, https://github.com/gmarik/Vundle.vim.git)

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive.git'
Plugin 'nanotech/jellybeans.vim.git'
Plugin 'tpope/vim-surround.git'
Plugin 'mbbill/undotree.git'
Plugin 'mileszs/ack.vim.git'
Plugin 'vim-scripts/Gist.vim.git'
Plugin 'junegunn/vim-easy-align.git'
Plugin 'vim-pandoc/vim-pandoc-syntax.git'
Plugin 'tpope/vim-abolish.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'michaeljsmith/vim-indent-object.git'
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'danro/rename.vim.git'
Plugin 'Lokaltog/vim-easymotion.git'
Plugin 'vim-scripts/n3.vim.git'
Plugin 'davidhalter/jedi-vim.git'
Plugin 'ervandew/supertab.git'
Plugin 'vim-scripts/openscad.vim'
Plugin 'jez/vim-ispc.git'
Plugin 'vim-erlang/vim-erlang-omnicomplete'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'nvie/vim-flake8'
Plugin 'psf/black'
Plugin 'kana/vim-operator-user'
Plugin 'junegunn/fzf.vim'
Plugin 'chr4/nginx.vim'
Plugin 'mesonbuild/meson', {'rtp': 'data/syntax-highlighting/vim/'}
Plugin '907th/vim-auto-save'
Plugin 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
Plugin 'airblade/vim-gitgutter'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'leafOfTree/vim-vue-plugin'

call vundle#end()
" configure jedi
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#smart_auto_mappings = 0

" configure supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let b:SuperTabNoCompleteAfter=['^ *']

" configure vim-pandoc-syntax
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#modules#disabled = ["folding"]
let g:tex_conceal = ""
set conceallevel=0

" configure LanguageClent
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['clangd'],
    \ }

let g:LanguageClient_diagnosticsDisplay = {
            \     1: {
            \         "name": "Error",
            \         "texthl": "ALEError",
            \         "signText": "e",
            \         "signTexthl": "ALEErrorSign",
            \         "virtualTexthl": "Error",
            \     },
            \     2: {
            \         "name": "Warning",
            \         "texthl": "ALEWarning",
            \         "signText": "w",
            \         "signTexthl": "ALEWarningSign",
            \         "virtualTexthl": "Todo",
            \     },
            \     3: {
            \         "name": "Information",
            \         "texthl": "ALEInfo",
            \         "signText": "i",
            \         "signTexthl": "ALEInfoSign",
            \         "virtualTexthl": "Todo",
            \     },
            \     4: {
            \         "name": "Hint",
            \         "texthl": "ALEInfo",
            \         "signText": "h",
            \         "signTexthl": "ALEInfoSign",
            \         "virtualTexthl": "Todo",
            \     },
            \ }

" configure gitgutter
let g:gitgutter_enabled = 0
set updatetime=200

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

" Configure flake8
au FileType python noremap <buffer> <Leader>c :call Flake8()<CR>
au FileType python noremap <buffer> <Leader>C :call flake8#Flake8UnplaceMarkers()<CR>
let g:flake8_show_in_gutter=1

" Configure black
au FileType python map <buffer><Leader>= :Black<CR>

" Configure ack.vim to work with ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" autosave notes
augroup notes
    autocmd!
    autocmd BufNewFile,BufRead ~/notes/* let b:auto_save = 1
augroup END

set mouse=a

" hack from
" https://vi.stackexchange.com/questions/13971/vim-pasting-yank-register-when-opening-a-new-file
" doesn't currently seem to be required
" set t_RS=

" Whitespace
set expandtab
set list
set shiftwidth=4
set tabstop=4

set spelllang=en_gb

" Looks
set number
set relativenumber
set guifont=IF_COMPUTER(UBUNTU, Terminus\ 8, Terminus\ Medium\ 8)
set guioptions-=T
set guioptions-=m
set guioptions-=e " GTK tabs are less functional and take up more room.
colorscheme jellybeans
set showcmd
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set cursorline

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set wildignore+=*.so,*.swp,*~
set wildmode=longest,list " readline sytle completion

" https://github.com/junegunn/fzf.vim/issues/900
let &t_TI = ""
let &t_TE = ""

map <Leader>sv :so $MYVIMRC<CR>
map <Leader>u :UndotreeToggle<CR>
map <Leader>t :GFiles<CR>
map <Leader>T :Files<CR>
map <Leader>b :Buffers<CR>
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
map <Leader>mk :call mkdir(expand('%:h'), 'p')<CR>
nmap <Leader>fq :%s/[„“”]/"/g<CR>
vmap <Leader>fq :s/[„“”]/"/g<CR>
nnoremap g< :SidewaysLeft<cr>
nnoremap g> :SidewaysRight<cr>

" probably my most common typo
command! W w

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
autocmd FileType c,cpp setlocal commentstring=//\ %s

function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
        nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
        nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
        set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
        map <buffer><Leader>= :call LanguageClient#textDocument_formatting_sync()<CR>
    endif
endfunction

autocmd FileType * call LC_maps()

au FileType tex let b:surround_109 = "\\(\r\\)"
au FileType tex let b:surround_77 = "\\[\r\\]"

" recognise '#. ' lists for pandoc markdown
au FileType markdown set flp+=\\\\|^#.\\s\\+

au Filetype verilog let b:verilog_indent_modules = 1

au Filetype mail set spell
au Filetype rst set spell
au Filetype markdown set spell

" allow telling vim to not write any swap/backup/view files.
if $VIM_NO_WRITE_TMP == 1
	set noswapfile
	set nobackup
	set noundofile
	set viminfo=
else
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

	set directory=$HOME/.vim/swap//
endif

" in git edit messages, start at line 0 and turn on spell checking
au BufWinEnter COMMIT_EDITMSG call cursor(1, 1)
au BufWinEnter COMMIT_EDITMSG set spell

if filereadable(".vim.custom")
    so .vim.custom
endif


CONFIG_FILE(vim, ~/.vim/after/ftplugin/c.vim)
" recognise doxygen comments
" ideally this would just be an autocommand, but on older vims (I think) this
" is overriden by the builtin ftplugin D:
setlocal comments^=:///
