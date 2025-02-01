return {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("onedark").setup({

            style = "darker",
            transparent = false, -- Hiển thị nền trong suốt
            term_colors = true, -- Thay đổi màu terminal theo theme đã chọn
            ending_tildes = true, -- Hiển thị dấu ngã ở cuối buffer
            cmp_itemkind_reverse = false, -- Đảo ngược các highlight item kind trong cmp menu

            -- toggle theme style ---
            toggle_style_key = "<leader>ts", -- Phím tắt để thay đổi style
            toggle_style_list = {"darker", "cool", "light"},
            -- toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, 

            -- Thay đổi kiểu code ---
            code_style = {
                types = "bold",
                numbers = "NONE",
                strings = "NONE",
                comments = "italic",
                keywords = "bold,italic",
                constants = "NONE",
                functions = "italic",
                operators = "NONE",
                variables = "italic",
                conditionals = "italic",
                virtual_text = "NONE"
            },

            -- Cấu hình cho lualine --
            lualine = {
                transparent = false -- Sự trong suốt của lualine
            },

            -- Custom Highlights --
            colors = {
                bg = "#1F2126",
                indentline = "#E25252",
                grey = "#3B4252",
                -- red = "#FF838A",
                cyan = "#5DB7FF",
                -- yellow = "#F27B35",
                orange = "#EA8333",
                -- green = "#86C05E",
                -- blue = "#5DB7FF",
                purple = "#E389F5"

            },


            options = {
                bold = true, -- Use bold styles?
                italic = true, -- Use italic styles?
                underline = true, -- Use underline styles?
                undercurl = true, -- Use undercurl styles?

                cursorline = true, -- Use cursorline highlighting?
                transparency = false, -- Use a transparent background?
                terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
                highlight_inactive_windows = false -- When the window is out of focus, change the normal background?
            },

            -- Plugins Config --
            diagnostics = {
                darker = true, -- Màu tối hơn cho chẩn đoán
                undercurl = true, -- Sử dụng undercurl thay vì gạch chân cho chẩn đoán
                background = true -- Sử dụng màu nền cho văn bản ảo
            }
        })
        require("onedark").load()
        vim.api.nvim_set_hl(0, "CursorLine", {
            fg = "none",
            bg = "none"
        })
        vim.api.nvim_set_hl(0, "CursorLineNR", {
            fg = "orange",
            bold = true
        })
        vim.api.nvim_set_hl(0, "NormalFloat", {
            bg = "none"
        })
        vim.api.nvim_set_hl(0, "FloatBorder", {
            bg = "none"
        })
    end
}

