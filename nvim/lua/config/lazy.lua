-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
                   lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Load config
require("config.options")
require("config.autocmds")
require("config.keymaps")

-- Lazy.nvim
require("lazy").setup({
    { import = "plugins.core" },
    { import = "plugins.ui" },
})

local base46_cache_ok, base46_cache_files = pcall(vim.fn.readdir, vim.g.base46_cache)
if base46_cache_ok then
    for _, file in ipairs(base46_cache_files) do
        local cache_file = vim.g.base46_cache .. file
        if vim.fn.filereadable(cache_file) == 1 then
            dofile(cache_file)
        end
    end
end

