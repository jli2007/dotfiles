return {
  {
    -- Full git UI inside nvim; <leader>g then follow the prompts.
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    keys = { { '<leader>g', function() require('neogit').open() end, desc = 'Neogit' } },
    opts = {},
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    opts = {
      current_line_blame = true,   -- who last touched this line, inline
      current_line_blame_opts = { delay = 300 },
    },
  },
}
