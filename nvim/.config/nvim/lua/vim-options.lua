vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.cmd("set clipboard=unnamed") -- yank to clipboard MacOS
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set autoindent")
vim.cmd("set cursorline")
vim.cmd("set scrolloff=8")
vim.cmd("set signcolumn")
vim.cmd("set colorcolumn=120")
vim.opt.laststatus = 3 -- one global statusline instead of per-window
vim.opt.statusline = "%<%t %h%w%m%r%=%-14.(%l,%c%V%) %P" -- %t = filename only, no path
