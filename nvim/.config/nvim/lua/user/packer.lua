
return require('packer').startup(function(use)

    use 'itchyny/lightline.vim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'

    use 'NMAC427/guess-indent.nvim'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end,
    })

    use 'jesseleite/vim-noh'
    use 'norcalli/nvim-colorizer.lua'

end)

