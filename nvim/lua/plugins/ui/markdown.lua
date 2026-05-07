local notified_render_markdown_disabled = false

local function notify_render_markdown_disabled()
    if notified_render_markdown_disabled then
        return
    end

    notified_render_markdown_disabled = true
    vim.schedule(function()
        vim.notify(
            "Không có Treesitter parser cho markdown, đã tắt render-markdown.",
            vim.log.levels.INFO,
            { title = "Markdown" }
        )
    end)
end

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        enabled = function()
            local ok, treesitterHelper = pcall(require, "config.treesitter")
            if not ok then
                notify_render_markdown_disabled()
                return false
            end

            local has_parser = treesitterHelper.hasParser("markdown")
            if has_parser then
                return true
            end

            notify_render_markdown_disabled()
            return false
        end,
        config = function()
            require("render-markdown").setup({
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
