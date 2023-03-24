local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
    return
end

telescope.setup{
  defaults = {
      path_display={"truncate"}
  }
}

