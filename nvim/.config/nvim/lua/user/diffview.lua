local diffview_status_ok, diffview = pcall(require, "diffview")
if not diffview_status_ok then
    return
end


diffview.setup {
    use_icons = false,
    enhanced_diff_hl = true,
    keymaps = {
        view = { q = "<Cmd>DiffviewClose<CR>" },
        file_panel = { q = "<Cmd>DiffviewClose<CR>" },
        file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
    },
    file_panel = {
        win_config = {
            width = 50,
        }
    },
    view = {
        merge_tool = {
            layout = "diff4_mixed",
            disable_diagnostics = true,
        }
    }
}

