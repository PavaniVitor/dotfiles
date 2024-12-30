local M = {
  'kylechui/nvim-surround',
  version = '*',  -- Use for stability; omit to use the `main` branch for the latest features
  event = 'VeryLazy',  -- Load the plugin during a lazy event; adjust as needed
  config = function()
    require('nvim-surround').setup({
      -- Configuration here, or leave empty to use defaults
    })
  end
}

return { M }
