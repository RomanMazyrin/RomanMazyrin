let g:lightline = {
    \ 'colorscheme': 'catppuccin_mocha',
    \ 'component': {
    \   'lineinfo': '%l:%c (%L)',
    \ } 
\ }

set number
set relativenumber
set nowrap
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set mouse=a
set laststatus=2
set shortmess+=F
syntax on
set noshowmode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set signcolumn=yes
set updatetime=100

call plug#begin()

Plug 'michaeljsmith/vim-indent-object'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

colorscheme catppuccin_mocha

highlight SignColumn guibg=NONE ctermbg=NONE

" Swap j and k for Normal mode
nnoremap j k
nnoremap k j

" Swap j and k for Visual mode (so highlighting works too)
vnoremap j k
vnoremap k j

" Operator-Pending Mode (Fixes y3k, d2j, etc.)
onoremap j k
onoremap k j

" Create parent directories automatically when saving a file
augroup auto_mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END
