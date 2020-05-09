let mapleader = "\<Space>"

filetype plugin indent on
set encoding=utf-8
set number
set ruler
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
set list
set listchars=tab:\▸\-,trail:-,extends:»,precedes:«,nbsp:%
set ignorecase
set smartcase
set incsearch
set gdefault
set wrapscan
set hlsearch
set hidden
set showcmd
set relativenumber
set mouse=a " Enable mouse usage (all modes) in terminals
set undodir=~/.vimdid " Permanent undo
set undofile
set updatetime=300
set shortmess+=c
set signcolumn=yes
set pumblend=15
set numberwidth=5

" =============================================================================
" # Plugins
" =============================================================================

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'andymass/vim-matchup'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'machakann/vim-highlightedyank'
Plug 'preservim/nerdcommenter'
Plug 'terryma/vim-expand-region'
Plug 'cespare/vim-toml'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'sainnhe/gruvbox-material'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()


" =============================================================================
" # Looks
" =============================================================================

syntax enable
set background=dark
let g:gruvbox_material_background = 'medium'
colorscheme gruvbox-material

" lightline
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }


" =============================================================================
" # Key mappings
" =============================================================================

nnoremap j gj
nnoremap k gk
nnoremap <C-k> gk
inoremap <silent> jj <ESC>
inoremap <silent> jk <ESC>
inoremap <silent> <C-h> <ESC>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Open hotkeys
map <C-p> :GFiles<CR>
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Jump to start and end of line using the home row keys
map H ^
map L $

" Easy to split windows and move between them
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT

" Emacs-like key bindings in command line mode
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" =============================================================================
" # Coc.nvim settings
" =============================================================================

let g:coc_global_extensions = [
          \ 'coc-css',
          \ 'coc-git',
          \ 'coc-highlight',
          \ 'coc-html',
          \ 'coc-json',
          \ 'coc-pairs',
          \ 'coc-prettier',
          \ 'coc-python',
          \ 'coc-rust-analyzer',
          \ 'coc-tsserver',
          \ 'coc-yaml'
          \ ]

" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" navigate to the next item
inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"

" navigate to the previous item
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <C-.> to trigger completion
inoremap <silent><expr> <C-.> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <CR> to confirm completion when completions are shown,
" in other cases to format code style.
inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <Tab> to go next placeholder in snippet
let g:coc_snippet_next = '<Tab>'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `gh` to show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Prettier` to format current buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Remap keys for range format
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current line
nmap <leader>a  <Plug>(coc-codeaction)

" Change diagnotic sign character
let g:coc_status_error_sign = has('mac') ? '❌ ' : 'E: '
let g:coc_status_warning_sign = has('mac') ? '⚠︎  ' : 'W: '

" =============================================================================
" # Plugin settings
" =============================================================================

" easymotion
nmap <leader>t <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable the default mappings

" <leader>s for Rg search
noremap <leader>s :Rg<Enter>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --hidden --glob '!*.lock' --column --line-number --no-heading --color=always ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ripgrep
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" :GFiles include untracked files
" See https://github.com/junegunn/fzf.vim/issues/129
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#gitfiles('--exclude-standard --cached --others')

" nerdtree
noremap <leader>n :NERDTreeToggle<CR>
" Show hidden files by default
let NERDTreeShowHidden=1

" =============================================================================
" # Autocommands
" =============================================================================

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Auto-loading a file as soon as it changes on disk
set autoread
au CursorHold * checktime
