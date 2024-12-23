return {
  'morhetz/gruvbox',
  priority = 1000,  -- Ensures the colorscheme loads early
  config = function()
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.cmd.colorscheme('gruvbox')
  end
}
