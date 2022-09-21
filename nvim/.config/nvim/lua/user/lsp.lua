

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


-- TODO: download arduino-ide and steal lsp dependencies.

local MY_FQBN = "teensy:avr:teensy41"
local arduino_lsp_folder = os.getenv("HOME") .. "/arduino-ls/resources/app/node_modules/arduino-ide-extension/build/"
local arduino_config_folder = os.getenv("HOME") ..  "/.arduinoIDE/"

lspconfig.arduino_language_server.setup {
    cmd = {
          arduino_lsp_folder .. "arduino-language-server",
        "-clangd",  arduino_lsp_folder .. "clangd",
        "-cli", arduino_lsp_folder .. "arduino-cli",
        "-fqbn", MY_FQBN,
        "-cli-config", arduino_config_folder .. "arduino-cli.yaml"
        -- "-cli-daemon-addr", "localhost:50051",
        -- "-cli-daemon-instance", "1",
        -- "-skip-libraries-discovery-on-rebuild",
        -- "-board-name", "Teensy 4.1"
    }
}

