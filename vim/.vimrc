set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'tpope/vim-surround'
Plugin '2072/PHP-Indenting-for-VIm'

call vundle#end()

filetype plugin indent on
filetype indent on      " load filetype-specific indent files

set nocompatible


" colors
syntax enable	        " enable syntax processing

set background=dark
colorscheme gruvbox


" tabs and spaces
set tabstop=4       	" number of visual spaces per TAB
set softtabstop=4   	" number of spaces in tab when editing
set expandtab       	" tabs are spaces


" ui config
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line

set novisualbell        " power off visual bell


set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]


" search
set incsearch           " search as characters are entered
set hlsearch            " highlight matches


" encdoing
set encoding=utf8
set fileencoding=utf8
set termencoding=utf8


" movement
nnoremap j gj
nnoremap k gk


" mouse
set mousehide
set mouse=a
set mousemodel=popup


set backupdir=~/.vim/backup//
set directory=~/.vim/swap//


" Quick jumping between splits
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

autocmd BufWritePre * %s/\s\+$//e
