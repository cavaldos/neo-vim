return {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"},
    config = function()
        require('aerial').setup()
        -- tao phim tat
        vim.keymap.set("n", "<C-a>", "<CMD>AerialToggle<CR>", {
            noremap = true,
            silent = true
        })

    end

}
