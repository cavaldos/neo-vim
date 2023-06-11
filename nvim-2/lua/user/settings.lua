-- vim.opt.backup = false                                         -- creates a backup file
-- vim.opt.clipboard = ""                                         -- allows neovim to access the system clipboard
-- vim.opt.fileencoding = "utf-8"                                 -- the encoding written to a file
-- vim.opt.hlsearch = true                                        -- highlight all matches on previous search pattern
-- vim.opt.ignorecase = true                                      -- ignore case in search patterns
-- vim.opt.mouse = "a"                                            -- allow the mouse to be used in neovim
-- vim.opt.swapfile = false                                       -- creates a swapfile
-- vim.opt.termguicolors = true                                   -- set term gui colors (most terminals support this)
-- vim.opt.writebackup = false                                    -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
-- vim.opt.expandtab = true                                       -- convert tabs to spaces
-- vim.opt.shiftwidth = 2                                         -- the number of spaces inserted for each indentation
-- vim.opt.tabstop = 2                                            -- insert 2 spaces for a tab
-- vim.opt.cursorline = true                                      -- highlight the current line
-- vim.opt.number = true                                          -- set numbered lines
-- vim.opt.signcolumn = "yes"                                     -- always show the sign column, otherwise it would shift the text each time
-- vim.opt.wrap = false                                           -- display lines as one long line
-- vim.opt.timeoutlen = 500                                       -- time to wait for a mapped sequence to complete (in milliseconds)
-- vim.opt.title = true      
-- set the title of window to the value of the titlestring
vim.opt.undofile = true -- enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- set an undo directory
vim.opt.completeopt = {"menu", "menuone", "noselect"} -- fix complete
vim.opt.foldmethod = "manual" -- folding, set to "expr" for treesitter based folding
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.updatetime = 100
-- faster completion
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

local icons = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = "ﰠ ",
    Variable = " ",
    Class = "ﴯ ",
    Interface = " ",
    Module = " ",
    Property = "ﰠ ",
    Unit = "塞 ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = "פּ ",
    Event = " ",
    Operator = " ",
    TypeParameter = ""
}

require("notify").setup({
    background_colour = "#000000"
})
