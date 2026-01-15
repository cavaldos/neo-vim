-- Colorscheme configuration
-- Theme được quản lý qua file cache (~/.config/nvim/.theme_cache)
-- Sử dụng <leader>th để chọn theme qua Telescope

return {
    -- OneDark theme
    -- {
    --     "navarasu/onedark.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("onedark").setup({
    --             style = "dark",
    --             transparent = false,
    --             term_colors = true,
    --             ending_tildes = true,
    --             cmp_itemkind_reverse = false,
    --
    --             toggle_style_key = "<leader>ts",
    --             toggle_style_list = { "darker", "cool", "light" },
    --
    --             code_style = {
    --                 types = "bold",
    --                 numbers = "NONE",
    --                 strings = "NONE",
    --                 comments = "italic",
    --                 keywords = "bold,italic",
    --                 constants = "NONE",
    --                 functions = "italic",
    --                 operators = "NONE",
    --                 variables = "italic",
    --                 conditionals = "italic",
    --                 virtual_text = "NONE"
    --             },
    --
    --             lualine = {
    --                 transparent = false
    --             },
    --
    --             colors = {
    --                 bg0 = "#1e222a",
    --                 bg1 = "#353b45",
    --                 bg2 = "#3e4451",
    --                 bg3 = "#545862",
    --                 bg_d = "#1b1f27",
    --                 black = "#1e222a",
    --                 fg = "#abb2bf",
    --                 grey = "#42464e",
    --                 light_grey = "#6f737b",
    --                 red = "#e06c75",
    --                 orange = "#d19a66",
    --                 yellow = "#e5c07b",
    --                 green = "#98c379",
    --                 cyan = "#56b6c2",
    --                 blue = "#61afef",
    --                 purple = "#c678dd",
    --                 baby_pink = "#DE8C92",
    --                 pink = "#ff75a0",
    --                 vibrant_green = "#7eca9c",
    --                 nord_blue = "#81A1C1",
    --                 sun = "#EBCB8B",
    --                 dark_purple = "#c882e7",
    --                 teal = "#519ABA",
    --             },
    --
    --             options = {
    --                 bold = true,
    --                 italic = true,
    --                 underline = true,
    --                 undercurl = true,
    --                 cursorline = true,
    --                 transparency = false,
    --                 terminal_colors = true,
    --                 highlight_inactive_windows = false
    --             },
    --
    --             diagnostics = {
    --                 darker = true,
    --                 undercurl = true,
    --                 background = true
    --             }
    --         })
    --     end
    -- },
    --
    -- Catppuccin theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false,
                show_end_of_buffer = false,
                term_colors = true,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                no_italic = false,
                no_bold = false,
                no_underline = false,
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = { "italic" },
                    keywords = { "bold", "italic" },
                    strings = {},
                    variables = { "italic" },
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = { "bold" },
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    neotree = true,
                    treesitter = true,
                    notify = true,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    telescope = {
                        enabled = true,
                    },
                    indent_blankline = {
                        enabled = true,
                        scope_color = "lavender",
                        colored_indent_levels = false,
                    },
                    bufferline = true,
                    mason = true,
                    noice = true,
                    which_key = true,
                    aerial = true,
                    dashboard = true,
                },
            })
        end
    },

    -- OneDark.vim (classic Vimscript version)
    {
        "joshdick/onedark.vim",
        name = "onedark-vim",
        lazy = false,
        priority = 1000,
        config = function()
            -- Cấu hình trước khi load colorscheme
            vim.g.onedark_terminal_italics = 1
            vim.g.onedark_hide_endofbuffer = 1

            -- Override màu Visual selection (rgb 31,34,41 = #1f2229)
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "onedark",
                callback = function()
                    vim.api.nvim_set_hl(0, "Visual", { bg = "#1f2229" })
                end
            })
        end
    },

    -- Gruvbox theme
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                terminal_colors = true,
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,
                contrast = "", -- "hard", "soft" hoặc "" (medium)
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end
    },
}
