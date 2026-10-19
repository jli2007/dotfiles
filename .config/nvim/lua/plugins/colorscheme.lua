return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,   -- load before everything else
    config = function()
      require('rose-pine').setup({
        variant = 'moon',
        dark_variant = 'moon',
        styles = {
          italic = false,
          -- Transparent so Ghostty's background-opacity shows through.
          transparency = true,
        },
      })
      vim.cmd('colorscheme rose-pine')

      -- The picker's dimmed directory text is too dark to read
      -- against a transparent background; lift it to `subtle`.
      local palette = require('rose-pine.palette')
      vim.api.nvim_set_hl(0, 'SnacksPickerDir', { fg = palette.subtle })
    end,
  },
}
