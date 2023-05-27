
local api = vim.api

-- setup:
-- download arduino-ide 2.0 and place its folder path below.

local config = {
    board_name = "arduino:avr:mega",
    ide_folder_path = os.getenv("HOME") .. "/arduino-ide/",
    cli_yaml_path = os.getenv("HOME") ..  "/.arduino15/arduino-cli.yaml"
}

-- Don't touch its art
local arduino_bin_folder = config.ide_folder_path .. "resources/app/node_modules/arduino-ide-extension/build/"
local arduino_cli = arduino_bin_folder .. "arduino-cli"
local clangd = arduino_bin_folder .. "clangd"
local arduino_lsp = arduino_bin_folder .. "arduino-language-server"

-- TODO:
-- allow passing additional args to arduino_lsp

local lsp_status_ok, lspconfig = pcall(require, "lspconfig")

-- configure arduino_lsp if lspconfig is present

if lsp_status_ok then
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.semanticTokens = vim.NIL
    capabilities.workspace.semanticTokens = vim.NIL

    lspconfig.arduino_language_server.setup {
        capabilities = capabilities,
        on_attach = function(client, buf)
        end,
        cmd = {
            arduino_lsp,
            "-clangd", clangd,
            "-cli", arduino_cli,
            "-fqbn", config.board_name,
            "-cli-config", config.cli_yaml_path
    }
}
end

local win = nil
local arduino_command = function(command, message)

    if win == nil or not vim.api.nvim_win_is_valid(win) then
        vim.cmd('split')
        win = vim.api.nvim_get_current_win()
    end

    local output_bufnr = vim.api.nvim_create_buf(true, true)

    vim.api.nvim_win_set_buf(win, output_bufnr)

    local append_data = function(_, data)
        if data then
            vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
            vim.api.nvim_set_current_win(win)
        end
    end

    vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, {message})

    -- TODO: allow colored output
    command = command .. " --no-color"

    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data
    })
end


local compile = function()
    local ino_file = vim.api.nvim_buf_get_name(0)
    local command = arduino_cli .. " compile -b " .. config.board_name .. " " .. ino_file
    arduino_command(command, command)
end

local upload = function(upload_port)
    local ino_file = vim.api.nvim_buf_get_name(0)
    local command = arduino_cli .. " upload " .. "-b " .. board_name .. " " .. ino_file .. " -p " .. upload_port
    arduino_command(command, command)
end


-- create Arduino user commands.
api.nvim_create_user_command("ArduinoCompile", function()
    compile()
end, { nargs = 0})

api.nvim_create_user_command("ArduinoUpload", function(opts)
    upload(opts.args)
end, { nargs = 1, complete = 'file'})

api.nvim_create_user_command("ArduinoCli", function(opts)
    arduino_command(arduino_cli .. " " .. opts.args, "")
end, { nargs = "?"})

-- TODO:
-- create user command to edit arduino-cli.yaml
-- create completion to ArduinoCli command

