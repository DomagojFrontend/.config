vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("i", "jk", "<ESC>")

--save/exit
vim.keymap.set("n", "<C-s>", ":w!<CR>")
vim.keymap.set("n", "<C-b>", ":q!<CR>")

--window managment
vim.keymap.set("n", "<leader>sv", "<C-w>v")
vim.keymap.set("n", "<leader>sh", "<C-w>s")
vim.keymap.set("n", "<leader>se", "<C-w>=")
vim.keymap.set("n", "<leader>sx", ":close<CR>")

--tab managment
vim.keymap.set("n", "<leader>to", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>")
vim.keymap.set("n", "<leader>tn", ":tabn<CR>")
vim.keymap.set("n", "<leader>tp", ":tabp<CR>")

--formatting with eslint
vim.keymap.set("n", "<leader>f", ":!eslint_d % --fix<CR>")
