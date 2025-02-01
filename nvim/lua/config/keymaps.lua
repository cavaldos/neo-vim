-- Map leader <Space>
vim.g.mapleader = " "

-- Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Jump center screen
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")
vim.keymap.set("n", "J", "5jzz")
vim.keymap.set("n", "K", "5kzz")

-- Next & Previous highlight search
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Indent block
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Split window
vim.keymap.set("n", "<leader>_", "<CMD>split<CR>")
vim.keymap.set("n", "<leader>|", "<CMD>vsplit<CR>")

-- Copy & Paste
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>y", '"+y')

-- Disable highlight search
vim.keymap.set("n", "<leader><Enter>", "<CMD>nohlsearch<CR>")
