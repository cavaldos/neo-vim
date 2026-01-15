return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
    },
    config = function()
        local cmp = require("cmp")

        -- Icons giống NvChad
        local lspkind_icons = {
            Namespace = "󰌗",
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰆧",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󱓻",
            File = "󰈚",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰊄",
            Table = "",
            Object = "󰅩",
            Tag = "",
            Array = "[]",
            Boolean = "",
            Number = "",
            Null = "󰟢",
            String = "󰉿",
            Calendar = "",
            Watch = "󰥔",
            Package = "",
            Copilot = "",
            Codeium = "",
            TabNine = "",
        }

        -- Format giống NvChad style "default"
        local function format(_, item)
            local icon = lspkind_icons[item.kind] or ""
            local kind = item.kind or ""

            item.kind = " " .. icon .. " " .. kind
            return item
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end
            },

            window = {
                completion = {
                    scrollbar = false,
                    side_padding = 1,
                    winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
                    border = "single",
                },
                documentation = {
                    border = "single",
                    winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
                },
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Down>"] = cmp.mapping.select_next_item(),
                ["<Up>"] = cmp.mapping.select_prev_item(),
            }),

            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "vsnip" },
                { name = "buffer" },
                { name = "path" },
            }),

            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = format,
            },
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
            light_grey = "#6f737b",
        }

        -- CMP highlights
        vim.api.nvim_set_hl(0, "CmpPmenu", { bg = colors.bg })
        vim.api.nvim_set_hl(0, "CmpSel", { bg = colors.black2, bold = true })
        vim.api.nvim_set_hl(0, "CmpBorder", { fg = colors.grey_fg })
        vim.api.nvim_set_hl(0, "CmpDoc", { bg = colors.darker_black })
        vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = colors.grey_fg })
        vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = colors.white })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = colors.blue, bold = true })

        -- Item kind highlights
        vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = colors.orange })
        vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = colors.blue })
        vim.api.nvim_set_hl(0, "CmpItemKindIdentifier", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = colors.purple })
        vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = colors.green })
        vim.api.nvim_set_hl(0, "CmpItemKindStructure", { fg = colors.purple })
        vim.api.nvim_set_hl(0, "CmpItemKindType", { fg = colors.yellow })
        vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = colors.blue })
        vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = colors.blue })
        vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = colors.yellow })
        vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = colors.blue })
        vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = colors.purple })
        vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = colors.teal })
        vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = colors.green })
        vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = colors.purple })
        vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = colors.purple })
        vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = colors.cyan })
        vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = colors.yellow })
        vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = colors.green })
    end
}
