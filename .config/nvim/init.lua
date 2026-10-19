-- Leader is <Space>. which-key pops up after you press it and
-- lists what's bound, so the keymap is self-documenting.
--
--   <leader>f  find files        <leader>s  grep across project
--   <leader>b  buffers           <leader>e  file browser (oil)
--   <leader>g  git (neogit)      <leader>w  write
--   gd         goto definition   <Esc>      clear search highlight
--
-- Plugins live in lua/plugins/*.lua and are auto-loaded by lazy.nvim.
require('vim_config')
require('plugin')
require('keys')
