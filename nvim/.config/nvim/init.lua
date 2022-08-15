vim.cmd[[
    source ~/.config/nvim/plug.vim
    source ~/.config/nvim/config.vim
]]
require("user.lsp")
require("user.autopairs")
require("user.cmp")
require("user.keymaps")
require("user.treesitter")
require("user.filetypes")
require("user.colorizer")
require("user.guess-ident")
require("user.null-ls")

