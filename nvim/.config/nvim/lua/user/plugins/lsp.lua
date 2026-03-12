local M = {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "saghen/blink.cmp",
        },

        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "html",
                    "clangd",
                    "pyright",
                }
            })

            -- html
            vim.lsp.config("html", {
                capabilities = capabilities,
                filetypes = { "html", "templ" },
                settings = {
                    html = {
                        format = {
                            templating = true,
                            wrapLineLength = 120,
                            wrapAttributes = "auto",
                        },
                        hover = {
                            documentation = true,
                            references = true,
                        },
                    },
                },
            })

            -- gdscript
            vim.lsp.config("gdscript", {
                capabilities = capabilities
            })

            -- lua
            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                            path = runtime_path,
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            -- enable servers
            vim.lsp.enable({
                "lua_ls",
                "html",
                "gdscript",
            })
        end
    }
}

return M
