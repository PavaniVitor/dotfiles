call plug#begin('~/.vim/plugged')

Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-repeat.git'

" autocompletion stuff
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'onsails/lspkind-nvim'
Plug 'windwp/nvim-autopairs'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'gruvbox-community/gruvbox'
Plug 'NMAC427/guess-indent.nvim'

" file navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'jesseleite/vim-noh'
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()

