return {{
    "MeanderingProgrammer/render-markdown.nvim",
    config = function()
        require("render-markdown").setup({
            refresh = { -- Cập nhật khi chỉnh sửa
                enabled = true,
                interval = 200
            },
            background = {
                enabled = true, -- Hiển thị nền
                shade = 2 -- Độ tối của nền (0-3)
            },
            code = {
                enabled = true, -- Hiển thị code block được tô sáng
                set_filetype = true -- Đặt filetype cho code block
            },
            highlights = {
                markdownH1 = "@text.title.1.marker.markdown",
                markdownH2 = "@text.title.2.marker.markdown",
                markdownH3 = "@text.title.3.marker.markdown",
                markdownH4 = "@text.title.4.marker.markdown",
                markdownH5 = "@text.title.5.marker.markdown",
                markdownH6 = "@text.title.6.marker.markdown",
                markdownCode = "@string"
            }
        })
    end
}}
