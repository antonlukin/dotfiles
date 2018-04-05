set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'sjl/badwolf'

call vundle#end()

filetype plugin indent on
filetype indent on      " load filetype-specific indent files

set nocompatible


" colors
syntax on               " enable syntax processing

set background=dark
colorscheme badwolf

" gruvbox options
if get(g:, 'colors_name', 'default') == 'gruvbox'
    let g:gruvbox_contrast_dark='hard'
    let g:gruvbox_bold='0'

    hi StatusLine ctermbg=15 ctermfg=24
    hi StatusLineNC ctermbg=15 ctermfg=239
endif


" tabs and spaces
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
set shiftwidth=4        " shift blocs

set cindent
set autoindent


" ui config
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set ch=1                " command line height

set novisualbell        " power off visual bell

set wildmenu
set wildmode=longest:list
set wildignore=*~

set showmatch           " highlight matching [{()}]
set nowrap              " stop wrapping long lines


" search
set incsearch           " search as characters are entered
set hlsearch            " highlight matches


" buffer
set hidden


" autocomplete
set completeopt-=preview
set completeopt+=longest
set mps-=[:]


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


" quick jumping between splits
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

autocmd BufWritePre * %s/\s\+$//e

" set options for default netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0


" status line
set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P
set laststatus=2

