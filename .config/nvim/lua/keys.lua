local map = vim.keymap.set

map('n', '<leader>w', '<cmd>write<cr>', { desc = 'Write' })
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })
map('n', '<C-a>', 'ggVG', { desc = 'Select all' })

-- Pasting over a visual selection keeps your clipboard intact
-- instead of replacing it with whatever you just overwrote.
vim.cmd([[ xnoremap <expr> p 'pgv"'.v:register.'y' ]])

-- Move between splits without the <C-w> prefix, mirroring the
-- hjkl pane navigation in tmux.
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
