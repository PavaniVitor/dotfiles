return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    ensure_installed = {
	    'vim',
	    'python',
	    'lua',
	    'cpp',
	    'bash',
    },
    highlight = {
	    enable = true,
	    additional_vim_regex_highlighting = false,
	    disable = {"xml"}
    },
    incremental_selection = {
	    enable = true,
	    keymaps = {
		    init_selection = '<leader>v',
		    scope_incremental = '<CR>',
		    node_incremental = '<TAB>',
		    node_decremental = '<S-TAB>',
	    },
    },
}

