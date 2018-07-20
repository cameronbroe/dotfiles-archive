set nocompatible " vim mode!

" Download plug-vim if not already {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" Plugins {{{
call plug#begin('~/.vim/bundle')
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
" Plug 'editorconfig/editorconfig-vim'
Plug 'sgur/vim-editorconfig'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-scripts/a.vim'
Plug 'vim-airline/vim-airline'
Plug 'Townk/vim-autoclose'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/restore_view.vim'
Plug 'pangloss/vim-javascript'
call plug#end()
" }}}

" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" General configuration {{{
syntax on
set number
set mouse=a
set cursorline

inoremap jj <esc>

" highlighting searches
set hlsearch
set incsearch

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  "if has("unnamedplus") " X11 support
  "  set clipboard+=unnamedplus
  "endif
endif

" Try and load color scheme
try
	colorscheme Benokai
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

" Some cool things
" Quick vimrc editing
nnoremap <leader>ev :e $MYVIMRC<cr>
" Quick vimrc reload
nnoremap <leader>sv :source $MYVIMRC<cr>

" Toggle line numbers in buffer
nnoremap <leader>l :set number!<cr>

" }}}

" UI configuration {{{
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

" set magic

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
" }}}


" Set :Q and :wQ to actually exit
" cnoreabbrev Q q
" cnoreabbrev wQ wq
" 
" " Set :q and :wq to only close buffer
" cnoreabbrev q bd
" cnoreabbrev wq w<bar>bd

" NERDTree configuration {{{
map <C-e> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
" }}}

" Airline configuration {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" BufExplorer configuration {{{
map <C-t> :ToggleBufExplorer<CR>
" }}}

" Ruby commands set up {{{
if has("ruby")
function! s:ExecuteRb(...) 
ruby << EOF
module VimScripts; end

# This is relative to the dotfiles repo
script_dir = "/ruby-scripts"

# Get resolved Vimrc directory to get to my dotfiles repo
vim_rc_dir = Vim::evaluate("resolve(expand($MYVIMRC))")
ruby_script_glob = (File.dirname(vim_rc_dir) + script_dir).to_s + '/*.rb'

ruby_files = Dir.glob(ruby_script_glob)
ruby_files.each do |rb|
	Vim::command("echom 'Loading #{rb}'")
    require rb
end

def invoke_method(scope, name, args)
    s_methods = (scope.methods - Module.methods).map { |m| m.to_s }
    if s_methods.include? name
        scope.send(name, *args)
    end
end

args = Vim::evaluate("a:000")

if args.length > 1
	ran_class = false
	VimScripts.constants.each do |c|
		if args.first == c.to_s.downcase
			class_obj = VimScripts.const_get(c)
			invoke_method(class_obj, args[1], args[2..-1])
			ran_class = true
		end
	end
	unless ran_class
		invoke_method(VimScripts, args.first, args[1..-1])
	end
elsif args.length == 1
    invoke_method(VimScripts, args.first, args[1..-1])
end

EOF
endfunction

command! -nargs=* Rbc call s:ExecuteRb(<f-args>)
endif
" }}}
