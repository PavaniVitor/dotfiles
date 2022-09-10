vim.cmd[[
    source ~/.config/nvim/plug.vim
]]
require("user.options")
require("user.lsp")
require("user.autopairs")
require("user.cmp")
require("user.keymaps")
require("user.treesitter")
require("user.filetypes")
require("user.colorizer")
require("user.guess-ident")
require("user.null-ls")
require("user.autocommands")

