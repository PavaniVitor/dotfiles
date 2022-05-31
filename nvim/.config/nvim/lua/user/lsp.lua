
local lsp_installer = require("nvim-lsp-installer")
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

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

