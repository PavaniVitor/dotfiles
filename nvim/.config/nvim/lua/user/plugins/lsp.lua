return {
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        'saghen/blink.cmp',
    },
    config = function()
     local capabilities = require('blink.cmp').get_lsp_capabilities()

      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
          }
        end,
      })

      local lspconfig = require("lspconfig")

      -- Specific LSP configurations
      lspconfig.gdscript.setup {}

      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "templ" },
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
        }
      })

      -- Lua LSP configuration
      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      lspconfig.lua_ls.setup({
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
        }
      })
    end
  }
}

