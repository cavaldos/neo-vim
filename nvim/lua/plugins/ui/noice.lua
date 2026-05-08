return {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
        require("noice").setup({
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
                format = {
                    cmdline     = { pattern = "^:",         icon = ">",  lang = "vim" },
                    search_down = { kind = "search", pattern = "^/",  icon = " ", lang = "regex" },
                    search_up   = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                    filter      = { pattern = "^:%s*!",               icon = "$",  lang = "bash" },
                    lua         = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                    help        = { pattern = "^:%s*he?l?p?%s+",      icon = "󰋖" },
                    input       = { view = "cmdline_input",            icon = "󰥻 " },
                },
            },

            messages  = { enabled = false },
            notify    = { enabled = false },

            popupmenu = {
                enabled = true,
                backend = "nui",
            },

            lsp = {
                progress = { enabled = false },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                    ["vim.lsp.util.stylize_markdown"] = false,
                    ["cmp.entry.get_documentation"] = false,
                },
                message = { enabled = false },
            },

            presets = {
                bottom_search         = false,
                command_palette       = false,
                long_message_to_split = false,
                inc_rename            = false,
                lsp_doc_border        = false,
            },

            views = {
                cmdline_popup = {
                    position = { row = "85%", col = "50%" },
                    size     = { width = 60, height = "auto" },
                    border   = {
                        style   = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                },

                cmdline_popupmenu = {
                    relative = "editor",
                    position = { row = "57%", col = "50%" },
                    size     = { width = 60, height = "auto", max_height = 10 },
                    border   = {
                        style   = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel",
                        cursorline   = true,
                    },
                },
            },
        })

        -- Tắt mouse khi ở cmdline để tránh mất focus
        vim.api.nvim_create_autocmd("CmdlineEnter", {
            callback = function() vim.o.mousemoveevent = false end,
        })
        vim.api.nvim_create_autocmd("CmdlineLeave", {
            callback = function() vim.o.mousemoveevent = true end,
        })

        -- Điều hướng popupmenu bằng phím mũi tên
        vim.keymap.set("c", "<Down>", function()
            return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>"
        end, { expr = true, noremap = true })

        vim.keymap.set("c", "<Up>", function()
            return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>"
        end, { expr = true, noremap = true })
    end,
}