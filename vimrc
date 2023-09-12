""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" ***** Plugins *****
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'scrooloose/nerdtree'	" Directory tree
Plug 'ryanoasis/vim-devicons'	" Icon for the nerdtree
Plug 'elkowar/yuck.vim'
Plug 'shougo/ddc.vim'
Plug 'itchyny/lightline.vim'
Plug 'cocopon/iceberg.vim'

call plug#end()

set background=dark    
colorscheme iceberg


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""" ***** Variables *****
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" Put icons on the nerdtree
let g:wbdevicons_enable_nerdtree = 1	

" Set lightline's theme
let g:lightline = { 'colorscheme': 'iceberg' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" ***** Options *****
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=UTF-8

""""" Settings
set nobackup
set noswapfile
set autoread
set hidden

""""" Appearance
set number		            " Show number of the line
set cursorline		        " Show horizontal highlighting 
set cursorcolumn	        " Show vertical highlighting
set nowrap
set virtualedit=onemore
set smartindent
set smarttab
set expandtab               " Use spaces as a tab
set shiftwidth=4	        " 4 Tab 
set tabstop=4
set laststatus=2
set wrapscan
set clipboard=unnamed
set hlsearch

syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" ***** Autosatrt commands *****
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto start nerdtree only if enter without filepath
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" ***** Keybinds *****
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disble arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Auto input the matched brackets
imap [ []<left>
imap ( ()<left>
imap { {}<left>




