return {
  {
    -- Edit a directory like a normal buffer: rename/delete/create
    -- by editing lines, then :w to apply.
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = { view_options = { show_hidden = true } },
    keys = { { '<leader>e', '<cmd>Oil<cr>', desc = 'File browser' } },
  },
  {
    'folke/snacks.nvim',
    priority = 900,
    lazy = false,
    opts = {
      picker   = { enabled = true },
      notifier = { enabled = true },
      input    = { enabled = true },
    },
    keys = {
      { '<leader>f', function() Snacks.picker.files() end,            desc = 'Find files' },
      { '<leader>s', function() Snacks.picker.grep() end,             desc = 'Grep project' },
      { '<leader>b', function() Snacks.picker.buffers() end,          desc = 'Buffers' },
      { '<leader>/', function() Snacks.picker.lines() end,            desc = 'Search in file' },
      { 'gd',        function() Snacks.picker.lsp_definitions() end,  desc = 'Goto definition' },
    },
  },
}
