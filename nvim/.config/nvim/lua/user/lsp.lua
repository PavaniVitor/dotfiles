

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
})

local lspconfig = require("lspconfig")
-- arduino language server from lsp_installer doesn't work so install it manually.
lspconfig.gdscript.setup {}

