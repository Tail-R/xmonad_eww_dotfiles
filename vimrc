""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim plug install command
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --------------------------------------------------------------------
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" --------------------------------------------------------------------

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

"" directory tree
Plug 'scrooloose/nerdtree'

"" eww extensions
" Plug 'elkowar/yuck.vim'

"" color schemes
Plug 'cocopon/iceberg.vim'

call plug#end()

set background=dark
colorscheme iceberg

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" variables
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=UTF-8

"" settings
set nobackup
set noswapfile
set autoread
set hidden

"" appearance
set number		            "" show number of the line
set cursorline		        "" show horizontal highlighting
set cursorcolumn	        "" show vertical highlighting
set nowrap
set virtualedit=onemore
set smartindent
set smarttab
set expandtab               "" use spaces as a tab
set shiftwidth=4	        "" 4 tab
set tabstop=4
set laststatus=2
set wrapscan
set clipboard=unnamed

syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" autosatrt commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" exec a nerdtree only if enterd without filepath
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" keybinds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" disble arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"" auto input the matched brackets
imap [ []<left>
imap ( ()<left>
imap { {}<left>

