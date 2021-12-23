vim.g.mapleader = ' '
vim.o.backup = false
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.exrc = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.signcolumn= 'yes'
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.softtabstop = 4
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.wrap = false

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent =  true})

vim.cmd('language en_US')
