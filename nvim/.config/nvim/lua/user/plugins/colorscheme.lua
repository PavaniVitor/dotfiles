local M = {
    "ellisonleao/gruvbox.nvim",
    config = function()
        require("gruvbox").setup {
            contrast = "hard",
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
            },
        }
        vim.cmd("colorscheme gruvbox")
    end,
}
return { M }
