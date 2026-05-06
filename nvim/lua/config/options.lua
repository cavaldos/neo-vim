-- Setting
vim.opt.number = true

vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true  -- Enable mouse events for clickable components
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.updatetime = 100

vim.opt.foldmethod = "marker"
vim.opt.cursorlineopt = "number"
-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indent
vim.opt.autoindent = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4


-- Statusline
vim.opt.laststatus = 3
vim.opt.backup = false
vim.opt.fileencoding = "utf-8"
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 300
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Undo
vim.opt.undofile = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.scrolloff = 8
-- vim.opt.fillchars = {
--     eob = " ",
--     vert = " ",      -- Ẩn đường kẻ dọc giữa các window
--     horiz = " ",     -- Ẩn đường kẻ ngang
--     vertleft = " ",
--     vertright = " ",
--     verthoriz = " ",
-- }

-- Fallback syntax highlighting cho trường hợp Treesitter chưa attach
vim.cmd("syntax enable")


vim.opt.swapfile = false

