
require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()

require("mason-lspconfig").setup_handlers({
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
        capabilities = capabilities,
    }
  end,
})


local lspconfig = require("lspconfig")
-- arduino language server from lsp_installer doesn't work so install it manually.
lspconfig.gdscript.setup {}

lspconfig.html.setup({
    capabilities = capabilities,
    filetypes = { "html", "templ" },
    opts = {
        settings = {
            html = {
                format = {
                    templating = true,
                    wrapLineLength = 120,
                    wrapAttributes = 'auto',
                },
                hover = {
                    documentation = true,
                    references = true,
                },
            },
        },
    }
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup({
settings = {
    Lua = {
    runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
    },
    diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
    },
    workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
        enable = false,
    },
    },
},
})


