""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'scrooloose/nerdtree'	" Directory tree
Plug 'ryanoasis/vim-devicons'	" Icon for the nerdtree
Plug 'elkowar/yuck.vim'
Plug 'shougo/ddc.vim'
Plug 'itchyny/lightline.vim'
Plug 'cocopon/iceberg.vim'

call plug#end()

colorscheme iceberg


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""" Variables
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

"" Put icons on the nerdtree
let g:wbdevicons_enable_nerdtree = 1	

"" Set lightline's theme
let g:lightline = { 'colorscheme': 'iceberg' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number		"" Show number of the line
set smarttab
set shiftwidth=4	"" 4 Tab 
set background=dark    
set encoding=UTF-8
set cursorline		"" Highlight current line
set noshowmode
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" Autosatrt commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Auto start nerdtree only if enter without filepath
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" Keybinds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Disble arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>



