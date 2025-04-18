local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank_group = augroup('highlight_yank', {})
local relative_number = augroup('relative_number', {})
local cursor_line = augroup('cursor_line', {})
local pavani = augroup('pavani', {})

local sudo_write = require("user.sudo")


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

-- trim whitespaces and write sudo files
autocmd({"BufWriteCmd", }, {
    group = pavani,
    pattern = "*",
    callback = function()
        -- skip autocmd for oil buffers
        local exclude_ft = {"oil"}
        local current_ft = vim.bo.filetype
        for _, ft in ipairs(exclude_ft) do
            if current_ft == ft then
                pcall( vim.cmd, 'w')
                return
            end
        end

        local cursor = vim.api.nvim_win_get_cursor(0)
        local command = "%s/\\s\\+$//e"
        vim.cmd(command)
        vim.api.nvim_win_set_cursor(0, cursor)
        local ok, result = pcall( vim.cmd, 'w')
        if (ok) then
            return
        end
        sudo_write()
	vim.cmd("e! %")
    end,
})

-- relative numbers in insert mode
autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
    group = relative_number,
    pattern = "*",
    callback = function ()
        if vim.bo.filetype == "term" then
           return
        end
        vim.opt.relativenumber = true
    end
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

autocmd({"TermOpen"}, {
    group = pavani,
    callback = function()
        vim.opt_local.number = false
        vim.bo.filetype = "term"
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.cmd("startinsert")
    end,
})

-- run "go fmt" on golang files save
autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.cmd([[silent! lua vim.lsp.buf.format()]])
  end,
})
