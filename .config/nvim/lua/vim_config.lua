local o = vim.opt
vim.g.mapleader = ' '

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

o.number = true
o.relativenumber = true       -- relative elsewhere, absolute on the cursor line
o.signcolumn = 'yes'          -- stops the text jumping when git signs appear
o.cursorline = true

o.ignorecase = true
o.smartcase = true            -- case-sensitive only once you type a capital
o.incsearch = true
o.hlsearch = true

o.clipboard = 'unnamedplus'   -- share the system clipboard
o.undofile = true             -- undo history survives closing the file
o.swapfile = false
o.scrolloff = 10              -- keep context above/below the cursor
o.splitright = true
o.splitbelow = true
o.termguicolors = true        -- truecolor; works because tmux declares RGB
o.updatetime = 250
o.mouse = 'a'                 -- on, matching tmux's mouse setting
