--options
local opt = vim.opt
opt.number = true
opt.relativenumber = false
vim.o.expandtab = true
opt.tabstop = 2
vim.o.shiftwidth = 2
vim.opt.termguicolors = true
vim.cmd [[set clipboard=unnamedplus]]
vim.cmd [[packadd packer.nvim]]
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require('impatient')

--opt.number = true
--opt.relativenumber = true

--vim.scriptencoding = 'utf-8'
--opt.encoding = 'utf-8'
--opt.fileencoding = 'utf-8'

-- opt.scrolloff = 5
-- opt.sidescrolloff = 5

-- opt.hlsearch = true
-- opt.incsearch = true

-- opt.mouse = 'a'
-- opt.clipboard:append('unnamedplus')

-- opt.tabstop = 2
-- opt.softtabstop = 2
-- opt.shiftwidth = 2
-- opt.expandtab = true

-- opt.ignorecase = true
-- opt.smartcase = true

-- opt.swapfile = false
-- opt.autoread = true
-- vim.bo.autoread = true

-- opt.signcolumn = 'yes'
-- opt.list = true

-- opt.cursorline = true
-- opt.termguicolors = true

-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank({
--       higroup = 'IncSearch',
--       timeout = 300
--     })
--   end
-- })
