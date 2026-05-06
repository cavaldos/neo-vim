return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        config = function()
            local treesitterHelper = require("config.treesitter")

            require("render-markdown").setup({
                enabled = treesitterHelper.ensureParser("markdown"),
                refresh = {
                    enabled = true,
                    interval = 200,
                },
                background = {
                    enabled = true,
                    shade = 2,
                },
                code = {
                    enabled = true,
                    set_filetype = true,
                },
                highlights = {
                    markdownH1 = "@text.title.1.marker.markdown",
                    markdownH2 = "@text.title.2.marker.markdown",
                    markdownH3 = "@text.title.3.marker.markdown",
                    markdownH4 = "@text.title.4.marker.markdown",
                    markdownH5 = "@text.title.5.marker.markdown",
                    markdownH6 = "@text.title.6.marker.markdown",
                    markdownCode = "@string",
                },
            })
        end,
    },
}
