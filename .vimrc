syntax on
filetype on
set number
set ruler
"set wrap
set showmatch
set ignorecase
set incsearch
set hlsearch
set noshowmode

set foldenable
set foldlevelstart=10
set foldmethod=syntax

set backspace=indent,eol,start

let mapleader=','
nnoremap <leader><space> :nohlsearch<CR>
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>
nnoremap <space> za
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

vmap <C-P> y'>p

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set laststatus=2
set smartcase
set smarttab

set background=dark
set termguicolors

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
