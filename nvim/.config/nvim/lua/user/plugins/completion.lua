local M = {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',

  opts = {
    keymap = { preset = 'default' },
    signature = { enabled = true },

    appearance = {
      use_nvim_cmp_as_default = true,
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { "sources.default" }
}

return { M }

