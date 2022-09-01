-- holds exotic filetypes that I encounter in the wild
-- maybe use filetype.nvim? idk

-- ROS xml files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.launch", "*.world", "*.sdf"},
    command = "set filetype=xml"
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {".localrc"},
    command = "set filetype=sh"
})

