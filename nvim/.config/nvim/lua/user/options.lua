local set = vim.opt

-- styling
set.termguicolors = true
set.guicursor = ""
set.mouse = ""

-- set.noshowmode = true
set.number = true
set.signcolumn = "yes"

set.splitbelow = true
set.splitright = true

set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.smarttab = true
set.shiftround = true
set.autoindent = true
set.smartindent = true

-- modern editor search
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true

set.showmatch = true
set.backspace="indent,eol,start"

set.completeopt = {"menuone", "noinsert", "noselect"}

set.undofile = true
-- i really hate swap files!
set.backup = false
set.swapfile = false

-- keep cursor 'centered'
set.scrolloff = 8

-- the G ood stuff
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd([[colorscheme gruvbox]])


vim.g.netrw_banner = 0
vim.g.netrm_liststyle = 3
vim.g.netrw_altv = 1

