return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" },
    config = function()
        -- Màu sắc tùy chỉnh - tăng độ tương phản
        local colors = {
            -- Buffer được chọn (sáng hơn)
            bg_selected = "#282c34",
            fg_selected = "#ffffff",

            -- Buffer không được chọn (tối hơn)
            bg_inactive = "#1e222a",
            fg_inactive = "#5c6370",

            -- Fill background (tối nhất)
            bg_fill = "#15181d",

            -- Màu accent
            red = "#e06c75",
            orange = "#d19a66",
            yellow = "#e5c07b",
            green = "#98c379",
            cyan = "#56b6c2",
            blue = "#61afef",
            purple = "#c678dd",
            grey = "#3e4452",
        }

        require('bufferline').setup {
            options = {
                mode = "buffers",
                themable = true,
                numbers = "none",
                close_command = "bdelete! %d",
                right_mouse_command = "bdelete! %d",
                left_mouse_command = "buffer %d",
                middle_mouse_command = nil,
                indicator = {
                    icon = '▎',
                    style = 'icon'
                },
                offsets = { {
                    filetype = "neo-tree",
                    text = " File Explorer",
                    text_align = "center",
                    separator = true,
                    highlight = "Directory",
                } },
                buffer_close_icon = '󰅖',
                modified_icon = '●',
                close_icon = '󰅖',
                left_trunc_marker = '',
                right_trunc_marker = '',
                max_name_length = 18,
                max_prefix_length = 15,
                tab_size = 18,
                diagnostics = "nvim_lsp",
                diagnostics_update_in_insert = false,
                diagnostics_indicator = function(count, level)
                    local icon = level:match("error") and " " or " "
                    return " " .. icon .. count
                end,
                color_icons = true,
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,
                show_duplicate_prefix = true,
                persist_buffer_sort = true,
                separator_style = "slope",
                enforce_regular_tabs = false,
                always_show_bufferline = true,
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' }
                },
                sort_by = 'insert_after_current',

                -- Custom areas - Nút mũi tên điều hướng 2 đầu (click được)
                custom_areas = {
                    left = function()
                        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
                        if #buffers > 1 then
                            return {
                                {
                                    text = ' 󰁍 ',
                                    link = 'BufferLineIndicatorSelected',
                                    on_click = function()
                                        vim.cmd('BufferLineCyclePrev')
                                    end
                                },
                            }
                        end
                        return {}
                    end,
                    right = function()
                        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
                        if #buffers > 1 then
                            return {
                                {
                                    text = ' 󰁔 ',
                                    link = 'BufferLineIndicatorSelected',
                                    on_click = function()
                                        vim.cmd('BufferLineCycleNext')
                                    end
                                },
                            }
                        end
                        return {}
                    end,
                },

                -- Groups configuration
                groups = {
                    options = {
                        toggle_hidden_on_enter = true, -- Tự động mở group khi vào buffer trong group đó
                    },
                    items = {
                        {
                            name = " Tests",
                            highlight = { fg = colors.yellow },
                            priority = 2,
                            icon = "",
                            matcher = function(buf)
                                return buf.name:match('%_test') or
                                       buf.name:match('%_spec') or
                                       buf.name:match('test%_') or
                                       buf.name:match('spec%_') or
                                       buf.path:match('test/') or
                                       buf.path:match('tests/') or
                                       buf.path:match('__tests__/')
                            end,
                        },
                        {
                            name = " Docs",
                            highlight = { fg = colors.cyan },
                            priority = 3,
                            icon = "󰈙",
                            matcher = function(buf)
                                return buf.name:match('%.md$') or
                                       buf.name:match('%.txt$') or
                                       buf.name:match('%.rst$') or
                                       buf.name:match('README') or
                                       buf.name:match('CHANGELOG') or
                                       buf.name:match('LICENSE')
                            end,
                        },
                        {
                            name = " Config",
                            highlight = { fg = colors.orange },
                            priority = 4,
                            icon = "",
                            matcher = function(buf)
                                return buf.name:match('%.config%.') or
                                       buf.name:match('%.json$') or
                                       buf.name:match('%.yaml$') or
                                       buf.name:match('%.yml$') or
                                       buf.name:match('%.toml$') or
                                       buf.name:match('%.ini$') or
                                       buf.name:match('%.env') or
                                       buf.name:match('Makefile') or
                                       buf.name:match('Dockerfile') or
                                       buf.name:match('%.conf$')
                            end,
                        },
                        {
                            name = " Styles",
                            highlight = { fg = colors.purple },
                            priority = 5,
                            icon = "",
                            matcher = function(buf)
                                return buf.name:match('%.css$') or
                                       buf.name:match('%.scss$') or
                                       buf.name:match('%.sass$') or
                                       buf.name:match('%.less$') or
                                       buf.name:match('%.styl$')
                            end,
                        },
                        {
                            name = "󰌛 Components",
                            highlight = { fg = colors.green },
                            priority = 6,
                            icon = "󰌛",
                            matcher = function(buf)
                                return buf.path:match('components/') or
                                       buf.path:match('Components/')
                            end,
                        },
                        require('bufferline.groups').builtin.pinned:with({ icon = "" }),
                        require('bufferline.groups').builtin.ungrouped,
                    }
                },
            },
            highlights = {
                -- Background chung
                fill = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_fill,
                },
                background = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                },

                -- Tab đang được chọn (NỔI BẬT)
                buffer_selected = {
                    fg = colors.fg_selected,
                    bg = colors.bg_selected,
                    bold = true,
                    italic = false,
                },
                buffer_visible = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                },

                -- Close button
                close_button = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                },
                close_button_visible = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                },
                close_button_selected = {
                    fg = colors.red,
                    bg = colors.bg_selected,
                },

                -- Separator
                separator = {
                    fg = colors.bg_fill,
                    bg = colors.bg_inactive,
                },
                separator_visible = {
                    fg = colors.bg_fill,
                    bg = colors.bg_inactive,
                },
                separator_selected = {
                    fg = colors.bg_fill,
                    bg = colors.bg_selected,
                },

                -- Tab indicator
                indicator_selected = {
                    fg = colors.blue,
                    bg = colors.bg_selected,
                },
                indicator_visible = {
                    fg = colors.bg_inactive,
                    bg = colors.bg_inactive,
                },

                -- Modified indicator
                modified = {
                    fg = colors.orange,
                    bg = colors.bg_inactive,
                },
                modified_visible = {
                    fg = colors.orange,
                    bg = colors.bg_inactive,
                },
                modified_selected = {
                    fg = colors.green,
                    bg = colors.bg_selected,
                },

                -- Duplicate prefix
                duplicate = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                    italic = true,
                },
                duplicate_visible = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                    italic = true,
                },
                duplicate_selected = {
                    fg = colors.purple,
                    bg = colors.bg_selected,
                    italic = true,
                },

                -- Diagnostics
                diagnostic = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                },
                diagnostic_visible = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                },
                diagnostic_selected = {
                    fg = colors.fg_selected,
                    bg = colors.bg_selected,
                    bold = true,
                },

                -- Hint
                hint = {
                    fg = colors.cyan,
                    bg = colors.bg_inactive,
                },
                hint_visible = {
                    fg = colors.cyan,
                    bg = colors.bg_inactive,
                },
                hint_selected = {
                    fg = colors.cyan,
                    bg = colors.bg_selected,
                    bold = true,
                },
                hint_diagnostic = {
                    fg = colors.cyan,
                    bg = colors.bg_inactive,
                },
                hint_diagnostic_visible = {
                    fg = colors.cyan,
                    bg = colors.bg_inactive,
                },
                hint_diagnostic_selected = {
                    fg = colors.cyan,
                    bg = colors.bg_selected,
                    bold = true,
                },

                -- Info
                info = {
                    fg = colors.blue,
                    bg = colors.bg_inactive,
                },
                info_visible = {
                    fg = colors.blue,
                    bg = colors.bg_inactive,
                },
                info_selected = {
                    fg = colors.blue,
                    bg = colors.bg_selected,
                    bold = true,
                },
                info_diagnostic = {
                    fg = colors.blue,
                    bg = colors.bg_inactive,
                },
                info_diagnostic_visible = {
                    fg = colors.blue,
                    bg = colors.bg_inactive,
                },
                info_diagnostic_selected = {
                    fg = colors.blue,
                    bg = colors.bg_selected,
                    bold = true,
                },

                -- Warning
                warning = {
                    fg = colors.yellow,
                    bg = colors.bg_inactive,
                },
                warning_visible = {
                    fg = colors.yellow,
                    bg = colors.bg_inactive,
                },
                warning_selected = {
                    fg = colors.yellow,
                    bg = colors.bg_selected,
                    bold = true,
                },
                warning_diagnostic = {
                    fg = colors.yellow,
                    bg = colors.bg_inactive,
                },
                warning_diagnostic_visible = {
                    fg = colors.yellow,
                    bg = colors.bg_inactive,
                },
                warning_diagnostic_selected = {
                    fg = colors.yellow,
                    bg = colors.bg_selected,
                    bold = true,
                },

                -- Error
                error = {
                    fg = colors.red,
                    bg = colors.bg_inactive,
                },
                error_visible = {
                    fg = colors.red,
                    bg = colors.bg_inactive,
                },
                error_selected = {
                    fg = colors.red,
                    bg = colors.bg_selected,
                    bold = true,
                },
                error_diagnostic = {
                    fg = colors.red,
                    bg = colors.bg_inactive,
                },
                error_diagnostic_visible = {
                    fg = colors.red,
                    bg = colors.bg_inactive,
                },
                error_diagnostic_selected = {
                    fg = colors.red,
                    bg = colors.bg_selected,
                    bold = true,
                },

                -- Numbers
                numbers = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                },
                numbers_visible = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                },
                numbers_selected = {
                    fg = colors.blue,
                    bg = colors.bg_selected,
                    bold = true,
                },

                -- Tab
                tab = {
                    fg = colors.fg_inactive,
                    bg = colors.bg_inactive,
                },
                tab_selected = {
                    fg = colors.fg_selected,
                    bg = colors.bg_selected,
                    bold = true,
                },
                tab_separator = {
                    fg = colors.bg_fill,
                    bg = colors.bg_inactive,
                },
                tab_separator_selected = {
                    fg = colors.bg_fill,
                    bg = colors.bg_selected,
                },
                tab_close = {
                    fg = colors.red,
                    bg = colors.bg_inactive,
                },

                -- Pick
                pick = {
                    fg = colors.red,
                    bg = colors.bg_inactive,
                    bold = true,
                },
                pick_visible = {
                    fg = colors.red,
                    bg = colors.bg_inactive,
                    bold = true,
                },
                pick_selected = {
                    fg = colors.red,
                    bg = colors.bg_selected,
                    bold = true,
                },

                -- Offset separator
                offset_separator = {
                    fg = colors.grey,
                    bg = colors.bg_fill,
                },

                -- Trunc marker (hiển thị khi có buffer bị ẩn)
                trunc_marker = {
                    fg = colors.blue,
                    bg = colors.bg_fill,
                },
            }
        }

        -- Thiết lập phím tắt điều hướng Bufferline
        vim.keymap.set("n", "<A-.>", "<CMD>BufferLineCycleNext<CR>", { desc = "Buffer: Next" })
        vim.keymap.set("n", "<A-,>", "<CMD>BufferLineCyclePrev<CR>", { desc = "Buffer: Previous" })
        vim.keymap.set("n", "<A->>", "<CMD>BufferLineMoveNext<CR>", { desc = "Buffer: Move right" })
        vim.keymap.set("n", "<A-<>", "<CMD>BufferLineMovePrev<CR>", { desc = "Buffer: Move left" })
        vim.keymap.set("n", "<A-c>", "<CMD>Bdelete<CR>", { desc = "Buffer: Close" })
        vim.keymap.set("n", "<leader>bp", "<CMD>BufferLinePick<CR>", { desc = "Buffer: Pick" })
        vim.keymap.set("n", "<leader>bc", "<CMD>BufferLinePickClose<CR>", { desc = "Buffer: Pick close" })

        -- Group keymaps
        vim.keymap.set("n", "<leader>bt", "<CMD>BufferLineGroupToggle Tests<CR>", { desc = "Buffer: Toggle Tests group" })
        vim.keymap.set("n", "<leader>bd", "<CMD>BufferLineGroupToggle Docs<CR>", { desc = "Buffer: Toggle Docs group" })
        vim.keymap.set("n", "<leader>bg", "<CMD>BufferLineGroupToggle Config<CR>", { desc = "Buffer: Toggle Config group" })
        vim.keymap.set("n", "<leader>bs", "<CMD>BufferLineGroupToggle Styles<CR>", { desc = "Buffer: Toggle Styles group" })
        vim.keymap.set("n", "<leader>bm", "<CMD>BufferLineGroupToggle Components<CR>", { desc = "Buffer: Toggle Components group" })
        vim.keymap.set("n", "<leader>bP", "<CMD>BufferLineTogglePin<CR>", { desc = "Buffer: Pin/Unpin" })
    end
}
