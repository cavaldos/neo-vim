return {
    "nvim-lua/plenary.nvim",

    -- {
    --     "nvchad/ui",
    --     dependencies = { "nvim-tree/nvim-web-devicons" },
    --     config = function()
    --         require("nvchad")
    --     end,
    -- },

    {
        "nvchad/base46",
        lazy = false,
        priority = 1100,
        build = function()
            require("base46").load_all_highlights()
        end,
    },

    {
        "nvchad/volt",
        lazy = true,
    },
}
