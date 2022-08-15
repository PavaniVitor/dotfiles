

require("mason").setup()
require("mason-lspconfig").setup_handlers({
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
})

local lspconfig = require("lspconfig")
-- arduino language server from lsp_installer doesn't work so install it manually.
local MY_FQBN = "arduino:avr:leonardo"
lspconfig.arduino_language_server.setup {
    cmd = {
        "arduino-language-server",
        "-cli-config", "/home/vitor/.arduino15/arduino-cli.yaml",
        "-cli", "/home/vitor/.local/bin/arduino-cli",
        "-fqbn", MY_FQBN,
        "-cli-daemon-addr", "localhost:50051",
        "-cli-daemon-instance", "1",
        "-clangd", "/usr/bin/clangd"
    }
}

