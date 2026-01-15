return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        -- Chỉ cài đặt parsers khi chạy build (Lazy sync/update)
        local parsers = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }
        require("nvim-treesitter").install(parsers)
    end,
    lazy = false,
    config = function()
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        -- Bật treesitter highlight cho tất cả filetypes có parser
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
