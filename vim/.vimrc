set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'vim-scripts/xoria256.vim'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-repeat.git'

" autocompletion stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'williamboman/nvim-lsp-installer'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'onsails/lspkind-nvim'
Plug 'windwp/nvim-autopairs'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

call plug#end()

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

set splitbelow "open split below
set splitright "open vsplit files on the right side"

set laststatus=2 " lightline
set noshowmode " get rid of -- insert --

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab " use spaces instead of spaces.
set smarttab
set shiftround 
set autoindent
set smartindent

" Sane search
set ignorecase " case insensitive search
set smartcase " if there are uppercase letters, become case-sensitive
set hlsearch " highlight search
set incsearch " make search act like in modern browsers

set showmatch " show matching brackets

set backspace=indent,eol,start

" faster scrool with C-e C-y
nnoremap <C-y> 5<C-y>
nnoremap <C-e> 5<C-e>

" move lines with <C-j><C-h>
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap " "<c-g>u
inoremap ' '<c-g>u


:set number relativenumber
" norelative number in insert mode
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber

:augroup END

" turn backup off
set nobackup
set nowb 
set noswapfile

set autoread "auto read when a file is changed from outside

set wildmenu " tab completion menu

:color xoria256
set showcmd
syntax on

" netrw tweaks
let g:netrw_banner=0        " disable banner
let g:netrw_liststyle=3     " tree view
let g:netrw_altv=1          " open split to the right

" remove the annoying esc delay
set ttimeoutlen=5

set statusline+=%#warningmsg#
set statusline+=%*



