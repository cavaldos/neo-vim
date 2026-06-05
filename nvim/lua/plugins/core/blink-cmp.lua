return {
    "saghen/blink.cmp",
    dependencies = {"rafamadriz/friendly-snippets", -- snippets collection
    "hrsh7th/vim-vsnip" -- vim-vsnip (giữ nguyên engine snippet cũ)
    },
    version = "1.*", -- dùng tag để tải binary prebuilt

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- Keymap giữ nguyên thói quen từ nvim-cmp trước đó
        keymap = {
            preset = "none",
            ["<C-b>"] = {"scroll_documentation_up", "fallback"},
            ["<C-f>"] = {"scroll_documentation_down", "fallback"},
            ["<C-Space>"] = {"show", "fallback"},
            ["<C-e>"] = {"hide", "fallback"},
            ["<CR>"] = {"accept", "fallback"},
            ["<Down>"] = {"select_next", "fallback"},
            ["<Up>"] = {"select_prev", "fallback"}
        },

        appearance = {
            nerd_font_variant = "mono" -- đổi thành 'normal' nếu không dùng Nerd Font Mono
        },

        completion = {
            documentation = {
                auto_show = true,
                window = {
                    border = "single",
                    winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder"
                }
            },
            menu = {
                border = "single",
                scrollbar = true,
                winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLineFg:BlinkCmpMenuSelection"
            },
            list = {
                selection = {
                    preselect = false
                }
            }
        },

        sources = {
            default = {"lsp", "path", "snippets", "buffer"}
        },

        snippets = {
            preset = "vsnip"
        }, -- dùng vim-vsnip

        fuzzy = {
            implementation = "prefer_rust_with_warning"
        }
    },

    opts_extend = {"sources.default"},

    config = function(_, opts)
        require("blink.cmp").setup(opts)

 
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("blink_cmp_lsp_attach", {
                clear = true
            }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data and event.data.client_id or event.data)
                if client and client.supports_method and client:supports_method("textDocument/completion", event.buf) then
                    client.server_capabilities = vim.tbl_deep_extend("force", client.server_capabilities,
                        require("blink.cmp").get_lsp_capabilities())
                end
            end
        })

        -- Highlight groups giống NvChad
        local colors = {
            bg = "#1e222a",
            black2 = "#252931",
            darker_black = "#1b1f27",
            white = "#abb2bf",
            blue = "#61afef",
            green = "#98c379",
            red = "#e06c75",
            yellow = "#e5c07b",
            purple = "#c678dd",
            cyan = "#56b6c2",
            orange = "#d19a66",
            teal = "#519ABA",
            grey_fg = "#565c64",
            light_grey = "#6f737b"
        }

        local set_hl = function(name, val)
            vim.api.nvim_set_hl(0, name, val)
        end

        -- Menu
        set_hl("BlinkCmpMenu", {
            bg = colors.bg
        })
        set_hl("BlinkCmpMenuBorder", {
            fg = colors.grey_fg
        })
        set_hl("BlinkCmpMenuSelection", {
            bg = colors.black2,
            bold = true
        })
        set_hl("BlinkCmpDoc", {
            bg = colors.darker_black
        })
        set_hl("BlinkCmpDocBorder", {
            fg = colors.grey_fg
        })
        set_hl("BlinkCmpLabel", {
            fg = colors.white
        })
        set_hl("BlinkCmpLabelMatch", {
            fg = colors.blue,
            bold = true
        })
        set_hl("BlinkCmpLabelDeprecated", {
            fg = colors.light_grey,
            strikethrough = true
        })

        -- Item kind highlights (theo NvChad palette)
        set_hl("BlinkCmpKindConstant", {
            fg = colors.orange
        })
        set_hl("BlinkCmpKindFunction", {
            fg = colors.blue
        })
        set_hl("BlinkCmpKindMethod", {
            fg = colors.blue
        })
        set_hl("BlinkCmpKindConstructor", {
            fg = colors.blue
        })
        set_hl("BlinkCmpKindIdentifier", {
            fg = colors.red
        })
        set_hl("BlinkCmpKindField", {
            fg = colors.red
        })
        set_hl("BlinkCmpKindProperty", {
            fg = colors.red
        })
        set_hl("BlinkCmpKindVariable", {
            fg = colors.purple
        })
        set_hl("BlinkCmpKindValue", {
            fg = colors.cyan
        })
        set_hl("BlinkCmpKindSnippet", {
            fg = colors.red
        })
        set_hl("BlinkCmpKindText", {
            fg = colors.green
        })
        set_hl("BlinkCmpKindStructure", {
            fg = colors.purple
        })
        set_hl("BlinkCmpKindType", {
            fg = colors.yellow
        })
        set_hl("BlinkCmpKindKeyword", {
            fg = colors.white
        })
        set_hl("BlinkCmpKindFolder", {
            fg = colors.white
        })
        set_hl("BlinkCmpKindModule", {
            fg = colors.yellow
        })
        set_hl("BlinkCmpKindEnum", {
            fg = colors.blue
        })
        set_hl("BlinkCmpKindUnit", {
            fg = colors.purple
        })
        set_hl("BlinkCmpKindClass", {
            fg = colors.teal
        })
        set_hl("BlinkCmpKindFile", {
            fg = colors.white
        })
        set_hl("BlinkCmpKindInterface", {
            fg = colors.green
        })
        set_hl("BlinkCmpKindColor", {
            fg = colors.white
        })
        set_hl("BlinkCmpKindReference", {
            fg = colors.white
        })
        set_hl("BlinkCmpKindEnumMember", {
            fg = colors.purple
        })
        set_hl("BlinkCmpKindStruct", {
            fg = colors.purple
        })
        set_hl("BlinkCmpKindEvent", {
            fg = colors.yellow
        })
        set_hl("BlinkCmpKindOperator", {
            fg = colors.white
        })
        set_hl("BlinkCmpKindTypeParameter", {
            fg = colors.red
        })
    end
}
