return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup {
            defaults = {
                path_display = { "truncate" }
            }
        }

        local keymap = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }
        keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
        keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
        keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", opts)
        keymap("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", opts)
    end
}
