local M = {
  'nvim-treesitter/nvim-treesitter-context',
  opts = {
    enable = true,
    max_lines = 0,
    trim_scope = 'outer',
    min_window_height = 0,
    patterns = {
      default = {
        'class',
        'function',
        'method',
        'for',
        'while',
        'if',
        'switch',
        'case',
        'interface',
        'struct',
        'enum',
      },
      tex = { 'chapter', 'section', 'subsection', 'subsubsection' },
      haskell = { 'adt' },
      rust = { 'impl_item' },
      terraform = { 'block', 'object_elem', 'attribute' },
      scala = { 'object_definition' },
      vhdl = { 'process_statement', 'architecture_body', 'entity_declaration' },
      markdown = { 'section' },
      elixir = {
        'anonymous_function', 'arguments', 'block', 'do_block',
        'list', 'map', 'tuple', 'quoted_content',
      },
      json = { 'pair' },
      typescript = { 'export_statement' },
      yaml = { 'block_mapping_pair' },
      xml = { 'STag' },
    },
    exact_patterns = {},
    zindex = 20,
    mode = 'cursor',
    separator = nil,
  }
}

return { M }
