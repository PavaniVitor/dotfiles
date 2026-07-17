local M = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        ts.install({ "lua", "vim", "vimdoc", "query", "html" })

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("user.treesitter", { clear = true }),
            callback = function(args)
                local buf = args.buf
                local ft = vim.bo[buf].filetype
                local lang = vim.treesitter.language.get_lang(ft)

                print(lang)
                if not lang then
                    return
                end

                if not pcall(vim.treesitter.start, buf, lang) then
                    return
                end
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                vim.bo[buf].smartindent = false
                vim.bo[buf].cindent = false
            end,
        })

        local current_node = nil

        local function set_selection(node)
            if not node then
                return
            end
            current_node = node
            local sr, sc, er, ec = node:range()
            vim.api.nvim_buf_set_mark(0, "<", sr + 1, sc, {})
            vim.api.nvim_buf_set_mark(0, ">", er + 1, math.max(0, ec - 1), {})
            vim.cmd("normal! gv")
        end

        local function node_at_cursor()
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            return vim.treesitter.get_node({ pos = { row - 1, col } })
        end

        local function init_selection()
            set_selection(node_at_cursor())
        end

        local function node_incremental()
            local node = current_node or node_at_cursor()
            if node and node:parent() then
                set_selection(node:parent())
            end
        end

        local function node_decremental()
            local node = current_node
            if not node then
                return
            end
            local descendant = node_at_cursor()
            while descendant and descendant:parent() ~= node do
                descendant = descendant:parent()
            end
            if descendant and descendant ~= node then
                set_selection(descendant)
            end
        end

        vim.keymap.set("n", "<leader>v", init_selection, { desc = "Treesitter: init selection" })
        vim.keymap.set("v", "<CR>", node_incremental, { desc = "Treesitter: scope incremental" })
        vim.keymap.set("v", "<TAB>", node_incremental, { desc = "Treesitter: node incremental" })
        vim.keymap.set("v", "<S-TAB>", node_decremental, { desc = "Treesitter: node decremental" })
    end,
}

return { M }
