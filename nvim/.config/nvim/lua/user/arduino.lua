
local api = vim.api
local lspconfig = require("lspconfig")

-- setup:
-- download arduino-ide 2.0 and place its folder path below.
local board_name = "teensy:avr:teensy41" -- arduino FBQN
local arduino_ide_folder = "/home/vitor/arduino-ide/"
-- this will probably work, but .arduino15 can be .arduinoIDE if you use the ide 2.0
-- TODO: check for both?
local arduino_cli_yaml = os.getenv("HOME") ..  "/.arduino15/arduino-cli.yaml"


-- Don't touch its art
local arduino_bin_folder = arduino_ide_folder .. "resources/app/node_modules/arduino-ide-extension/build/"
local arduino_cli = arduino_bin_folder .. "arduino-cli"
local clangd = arduino_bin_folder .. "clangd"
local arduino_lsp = arduino_bin_folder .. "arduino-language-server"


-- TODO:
-- check for nvim lspconfig before setup lsp.
lspconfig.arduino_language_server.setup { cmd = {
    arduino_lsp,
    "-clangd", clangd,
    "-cli", arduino_cli,
    "-fqbn", board_name,
    "-cli-config", arduino_cli_yaml
    -- "-cli-daemon-addr", "localhost:50051",
    -- "-cli-daemon-instance", "1",
    -- "-skip-libraries-discovery-on-rebuild",
    -- "-board-name", "Teensy 4.1"
}
}

local win = nil
local arduino_command = function(command, message)

    if win == nil then
        vim.cmd('split')
        win = vim.api.nvim_get_current_win()
    end

    if not vim.api.nvim_win_is_valid(win) then
        vim.cmd('split')
        win = vim.api.nvim_get_current_win()
    end

    local output_bufnr = vim.api.nvim_create_buf(true, true)

    vim.api.nvim_win_set_buf(win, output_bufnr)

    local append_data = function(_, data)
        if data then
            vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
            vim.api.nvim_set_current_win(win)
            vim.cmd('%s/\\%x1b\\[[0-9;]*m//g') -- idk strip colors from cli output
        end
    end

    vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, {message})

    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data
    })
    print(win)
end


local compile = function()
    local ino_file = vim.api.nvim_buf_get_name(0)
    local command = arduino_cli .. " compile -b " .. board_name .. " " .. ino_file
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
end, { nargs = 1})

api.nvim_create_user_command("ArduinoCli", function(opts)
    arduino_command(arduino_cli .. " " .. opts.args, "")
end, { nargs = "?"})

api.nvim_create_user_command("ArduinoCli", function(opts)
    arduino_command(arduino_cli .. " " .. opts.args, "")
end, { nargs = "?"})

-- TODO:
-- create user command to edit arduino-cli.yaml

