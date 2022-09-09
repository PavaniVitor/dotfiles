set termguicolors
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

set mouse=
set splitbelow "open split below
set splitright "open vsplit files on the right side"

set laststatus=2 " lightline
set noshowmode " get rid of -- insert --

set guicursor=
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
set incsearch " make search act like in modern browsers
set hlsearch

set showmatch " show matching brackets
set backspace=indent,eol,start


set undodir=~/.vim/undodir
set undofile

:set number relativenumber


" turn backup off
set nobackup
set nowb
set noswapfile

set autoread "auto read when a file is changed from outside

set wildmenu " tab completion menu

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

set signcolumn=yes
set scrolloff=8
set showcmd
syntax on

" netrw tweaks
let g:netrw_banner=0        " disable banner
let g:netrw_liststyle=3     " tree view
let g:netrw_altv=1          " open split to the right

set statusline+=%#warningmsg#
set statusline+=%*

