set nocompatible " vim mode!
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-scripts/a.vim'
Plug 'vim-airline/vim-airline'
Plug 'Townk/vim-autoclose'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/restore_view.vim'
call plug#end()

" General configuration
syntax on
set number
set mouse=a

" Try and load color scheme
try
	colorscheme molokai
catch
endtry

set history=500
filetype plugin on
filetype indent on

set autoread

let mapleader = ","
nmap <leader>w :w!<cr>
command W w !sudo tee % > /dev/null

" Auto save folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" UI configuration
set ruler
set cmdheight=2

set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set magic

set foldcolumn=1

" Editing/display configuration
set expandtab

set smarttab

set shiftwidth=4
set tabstop=4
set ai
set si
set wrap
set lbr
set tw=500

" NERDTree configuration
map <C-e> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1

