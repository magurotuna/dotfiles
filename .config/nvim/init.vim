set encoding=utf-8
set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamed
set termguicolors
set autoread
set noswapfile
set nobackup
set nowritebackup
set showmatch
set list listchars=tab:\▸\-
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set hidden

" key map
nnoremap j gj
nnoremap k gk
inoremap <silent> jj <ESC>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

call plug#begin(stdpath('data') . '/plugged')

Plug 'mhartington/oceanic-next'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

syntax enable
colorscheme OceanicNext
