return {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"},
    config = function()
        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true
                }
            },
            -- Presets giúp định vị lại thanh tìm kiếm, cmdline
            presets = {
                bottom_search = true, -- Hiển thị thanh tìm kiếm ở dưới
                command_palette = false, -- Tắt popup ở giữa màn hình
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true
            },
            -- Cấu hình hiển thị thông báo ở phía dưới
            views = {
                cmdline_popup = {
                    position = {
                        row = "90%", -- Đặt popup cmdline ở dưới cùng
                        col = "50%" -- Căn giữa theo chiều ngang
                    },
                    size = {
                        width = 60,
                        height = "auto"
                    },
                    border = {
                        style = "rounded",
                        padding = {0, 1}
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
                    }
                },
                popupmenu = {
                    position = {
                        row = "90%", -- Đặt menu popup ở dưới cùng
                        col = "50%" -- Căn giữa theo chiều ngang
                    },
                    size = {
                        width = 60,
                        height = 10
                    },
                    border = {
                        style = "rounded",
                        padding = {0, 1}
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
                    }
                },
                messages = {
                    view = "mini", -- Định dạng gọn cho thông báo
                    position = {
                        row = "90%", -- Đưa xuống cuối màn hình
                        col = "50%"
                    }
                }
            }
        })
    end
}
