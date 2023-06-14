local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- disable arrow keys
keymap("n", "<Up>", "<Nop>", opts)
keymap("n", "<Down>", "<Nop>", opts)
keymap("n", "<Left>", "<Nop>", opts)
keymap("n", "<Right>", "<Nop>", opts)

-- faster scroll with C-e C-y
keymap("n", "<C-y>", "5<C-y>", opts)
keymap("n", "<C-e>", "5<C-e>", opts)

-- move lines with <C-j><C-h>
keymap("n", "<C-j>", ":m .+1<CR>==", opts)
keymap("n", "<C-k>", ":m .-2<CR>==", opts)
keymap("i", "<C-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<C-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- keep cursor centered on jumping to next/previos and joining lines
keymap("n", "N", "Nzzzv", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

-- insert undo checkpoints on symbols
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", "!", "!<c-g>u", opts)
keymap("i", "?", "?<c-g>u", opts)
keymap("i", '"', '"<c-g>u', opts)
keymap("i", "'", "'<c-g>u", opts)

-------------
-- PLUGINS --
-------------

-- lsp
keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)

-- telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", opts)

