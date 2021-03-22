set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
"source ~/.vimrc

"syntax on
"filetype on

set tabstop =4 softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set nu
set nohlsearch
set hidden
set noerrorbells
set nowrap
set ruler

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set incsearch
set scrolloff=8
set completeopt=menuone,noinsert,noselect
"set signcolumn=yes
set shortmess+=c

set foldenable
set foldlevelstart=10
set foldmethod=syntax

set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')
    Plug 'joshdick/onedark.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'scrooloose/nerdtree'
	Plug 'jiangmiao/auto-pairs'
	Plug 'luochen1990/rainbow'
	"Plug 'VelkyVenik/vim-avr'
	Plug '~/Documentos/AVR/vim-avr'
call plug#end()

let g:rainbow_active = 1
let g:NERDTreeChDirMode = 2
map <F2> :NERDTreeToggle<CR>

let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#default#section_truncate_width = {}

set nocompatible
let g:asmsyntax = 'tasm'

highlight Normal guibg=none
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
colorscheme onedark

set clipboard+=unnamedplus
filetype plugin indent on
syntax on

"mode lhs rhs
let mapleader = " "
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
