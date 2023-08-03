vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

    use 'wbthomason/packer.nvim'
    use 'itchyny/lightline.vim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'onsails/lspkind-nvim'
    use 'windwp/nvim-autopairs'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'


    use 'nvim-treesitter/nvim-treesitter'
    use 'gruvbox-community/gruvbox'
    use 'NMAC427/guess-indent.nvim'

    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use 'jesseleite/vim-noh'
    use 'norcalli/nvim-colorizer.lua'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'sindrets/diffview.nvim'

end)
