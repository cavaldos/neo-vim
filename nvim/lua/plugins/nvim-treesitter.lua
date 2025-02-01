return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline"},
            auto_install = true,
            autopairs = {
                enable = true
            },
            highlight = {
                enable = true
            }
        })
    end
}
