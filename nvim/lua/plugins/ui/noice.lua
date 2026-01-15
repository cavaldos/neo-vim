return {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
        require("noice").setup({
            -- Chỉ dùng noice cho cmdline
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
            },
            -- Tắt noice cho messages (dùng mặc định của Neovim)
            messages = {
                enabled = false,
            },
            -- Bật popupmenu cho autocomplete cmdline
            popupmenu = {
                enabled = true,
                backend = "nui", -- dùng nui để hiển thị autocomplete
            },
            -- Tắt noice cho notify (dùng mặc định của Neovim)
            notify = {
                enabled = false,
            },
            -- Tắt LSP progress/messages qua noice
            lsp = {
                progress = {
                    enabled = false,
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                    ["vim.lsp.util.stylize_markdown"] = false,
                    ["cmp.entry.get_documentation"] = false,
                },
                message = {
                    enabled = false,
                },
            },
            -- Presets
            presets = {
                bottom_search = true,
                command_palette = false,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = false,
            },
            -- Cấu hình cmdline popup
            views = {
                cmdline_popup = {
                    position = {
                        row = "86%",
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 0 },
                    },
                    win_options = {
                        -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                        -- winhighlight = "NormalFloat:Normal,FloatBorder:Normal",
                    },
                    -- Giữ cmdline không bị đóng khi di chuột
                    close = {
                        events = { "BufLeave" },
                        keys = { "q" },
                    },
                },
                cmdline_popupmenu = {
                    relative = "editor",
                    position = {
                        row = "83%",
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                        max_height = 10,
                    },
                    border = {
                        style = "none",
                        padding = { 1, 1},
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder,PmenuSel:PmenuSel,CursorLine:PmenuSel",
                        -- winhighlight = "NormalFloat:Normal,FloatBorder:Normal,PmenuSel:PmenuSel,CursorLine:PmenuSel",
                        cursorline = false,
                    },
                },
            },
        })

        -- Tắt mouse events trong cmdline mode để tránh mất focus
        vim.api.nvim_create_autocmd("CmdlineEnter", {
            callback = function()
                vim.o.mousemoveevent = false
            end,
        })
        vim.api.nvim_create_autocmd("CmdlineLeave", {
            callback = function()
                vim.o.mousemoveevent = true
            end,
        })

        -- Highlight cho item đang chọn trong popupmenu
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupMenuSelected", { link = "PmenuSel" })
        vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { link = "PmenuSel" })

        -- Dùng phím mũi tên lên/xuống để chọn trong cmdline autocomplete
        vim.keymap.set("c", "<Down>", function()
            if vim.fn.pumvisible() == 1 then
                return "<C-n>"
            else
                return "<Down>"
            end
        end, { expr = true, noremap = true })

        vim.keymap.set("c", "<Up>", function()
            if vim.fn.pumvisible() == 1 then
                return "<C-p>"
            else
                return "<Up>"
            end
        end, { expr = true, noremap = true })
    end,
}
