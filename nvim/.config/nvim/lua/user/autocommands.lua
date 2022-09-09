local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank_group = augroup('HighlightYank', {})
local pavani = augroup('pavani', {})


-- highlight yanked text
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 50,
        })
    end,
})

-- make all windows (almost) equally high and wide when vim window is resized.
autocmd('VimResized', {
    group = pavani,
    pattern = '*',
    command = 'execute "normal! \\<c-w>="',
})

