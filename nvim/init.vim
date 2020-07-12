set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ervandew/supertab'
Plug 'Shougo/neco-syntax'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Shougo/deoplete-clangx'
Plug 'scrooloose/nerdtree'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
"Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'terryma/vim-multiple-cursors'
Plug 'arcticicestudio/nord-vim'
" Plug 'vim-scripts/dbext.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()
let g:omni_sql_no_default_maps = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo = 0
" let g:SuperTabDefaultCompletionType = '<c-n>'
" let g:SuperTabMappingForward = '<c-space>'
" let g:SuperTabMappingBackward = '<s-c-space>'
let g:NERDTreeChDirMode = 2
let g:ale_set_highlights = 0
map <F2> :NERDTreeToggle<CR>
"let g:NERDSpaceDelims = 1
"let g:NERDTrimTrailingWhitespace = 1
let g:indentLine_fileType = ['html', 'python']
" let g:indentLine_enabled = 0
" let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
" let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']
" let g:indentLine_concealcursor = 'inc'
" let g:indentLine_conceallevel = 2
" let g:indentLine_char = '|'
" let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#default#section_truncate_width = {}
let g:asmsyntax = 'tasm'
" let g:dbtext_default_profile_mysql = 'type=MYSQL:user=root:host=localhost'
" let g:dbext_default_profile = 'mysql'
set clipboard+=unnamedplus
colorscheme nord
