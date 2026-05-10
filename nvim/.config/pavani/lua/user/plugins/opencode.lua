return {
    "nickjvandyke/opencode.nvim",
    -- version = "*", -- Latest stable release
    dependencies = {
        {
            "folke/snacks.nvim",
            optional = true,
            opts = {
                input = {}, -- Enhances `ask()`
                picker = {  -- Enhances `select()`
                    actions = {
                        opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
                    },
                    win = {
                        input = {
                            keys = {
                                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                            },
                        },
                    },
                },
            },
        },
    },
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            -- Your configuration, if any; goto definition on the type or field for details
        }

        vim.o.autoread = true -- Required for `opts.events.reload`

        -- Recommended/example keymaps
        -- Ask opencode about current context (with auto-submit)
        vim.keymap.set({ "n", "x" }, "<Leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end,
            { desc = "Ask opencode…" })
        vim.keymap.set({ "n", "x" }, "<Leader>ac", function() require("opencode").select() end,
            { desc = "Execute opencode action…" })
        -- Toggle opencode panel visibility
        vim.keymap.set({ "n", "t" }, "<Leader>ao", function() require("opencode").toggle() end,
            { desc = "Toggle opencode" })
        vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
            { desc = "Add range to opencode", expr = true })
        vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
            { desc = "Add line to opencode", expr = true })
    end,
}
