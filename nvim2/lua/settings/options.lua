-- options
local opt = vim.opt
opt.number = true
opt.relativenumber = false
vim.o.expandtab = true
opt.tabstop = 2
vim.o.shiftwidth = 2
vim.opt.termguicolors = true
vim.opt.completeopt = {"menu", "menuone", "noselect"} -- fix complete
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.cmd [[set clipboard=unnamedplus]]
vim.cmd [[packadd packer.nvim]]
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
require('impatient')

-- Ánh xạ u với Ctrl + z
vim.api.nvim_set_keymap('n', '<C-z>', 'u', {
    noremap = true
})
vim.api.nvim_set_keymap('n', '<C-S-Z>', '<C-r>', {
    noremap = true
})

-- Bật tự động lưu tất cả các tệp
-- vim.cmd([[set autowriteall]])
-- vim.cmd([[
--   augroup autosave
--     autocmd!
--     autocmd TextChanged,TextChangedI * silent! write
--   augroup END  
-- ]])

-- Giảm thời gian chờ xuống 0  
vim.o.updatetime = 3000

