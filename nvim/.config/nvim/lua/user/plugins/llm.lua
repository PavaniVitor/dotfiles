return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "j-hui/fidget.nvim",
    },
    init = function()
        vim.keymap.set({ "n", "v" }, "<LocalLeader>ca", "<cmd>CodeCompanionActions<cr>",
            { noremap = true, silent = true })
        vim.keymap.set({ "n", "v" }, "<LocalLeader>ci", "<cmd>CodeCompanionChat Toggle<cr>",
            { noremap = true, silent = true })
        vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
    end,

    opts = {
        strategies = {
            chat = {
                adapter = "opencode",
            },
            inline = {
                adapter = "zai",
            },
        },

        display = {
            diff = {
                enabled = true,
                provider = "mini_diff",
                word_highlights = {
                    additions = true,
                    deletions = true,
                },
            },
            chat = {
                show_token_count = true,
                fold_context = true,
                start_in_insert_mode = true,
            }
        },

        adapters = {
            acp = {
                opencode = "opencode",
            },

            http = {
                zai = function()
                    return require("codecompanion.adapters").extend("openai", {
                        formatted_name = "Z.ai GLM",
                        url = "https://api.z.ai/api/coding/paas/v4/chat/completions",

                        env = {
                            api_key = "ZAI_API_KEY",
                        },

                        schema = {
                            model = {
                                default = "glm-4.7",
                                choices = {
                                    "glm-4.7",
                                    "glm-4.6v",
                                    "glm-4.6v-flash",
                                },
                            },
                        },
                    })
                end,
            },
        },
    },
}
