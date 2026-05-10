local M = {
    "saghen/blink.cmp",
    version = "1.*",

    dependencies = {
        "rafamadriz/friendly-snippets",
    },

    build = "cargo build --release",

    -- Configuration for blink.cmp including keymaps, appearance, completion behavior, and sources
    opts = {
        keymap = { preset = "default" },

        signature = { enabled = true },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = {
            documentation = { auto_show = true },
            menu = {
                auto_show = true,
            },
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        cmdline = {
            enabled = true,

            completion = {
                menu = { auto_show = true },
            },

            sources = function()
                local type = vim.fn.getcmdtype()

                -- busca no buffer
                if type == "/" or type == "?" then
                    return { "buffer" }
                end

                -- command mode
                if type == ":" then
                    return { "cmdline", "path" }
                end

                return {}
            end,
        },
    },

    opts_extend = { "sources.default" }
}

return { M }
