local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank_group = augroup('highlight_yank', {})
local relative_number = augroup('relative_number', {})
local cursor_line = augroup('cursor_line', {})
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

-- trim whitespaces
autocmd({"BufWritePre"}, {
    group = pavani,
    pattern = "*",
    callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local command = "%s/\\s\\+$//e"
    vim.cmd(command)
    vim.api.nvim_win_set_cursor(0, cursor)
    end,
})

-- relative numbers in insert mode
autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
    group = relative_number,
    pattern = "*",
    command = 'set relativenumber',
})
autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
    group = relative_number,
    pattern = "*",
    command = 'set norelativenumber',
})

-- highlight cursor line
autocmd({"VimEnter", "WinEnter", "BufWinEnter"}, {
    group = cursor_line,
    pattern = "*",
    command = 'setlocal cursorline',
})
autocmd({"WinLeave"}, {
    group = cursor_line,
    pattern = "*",
    command = 'setlocal nocursorline',
})

