-- Vô hiệu hóa NetRW để tránh xung đột với Neo-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- Không bắt buộc, nhưng khuyến nghị
                    "MunifTanjim/nui.nvim"},
    config = function()
        -- ✅ FIX APPLY TRANSPARENT BACKGROUND CHO FLOATING WINDOWS CỦA NEO-TREE
        vim.api.nvim_set_hl(0, "NormalFloat", {
            fg = "#95B4D9",
            bg = "NONE"
        })
        vim.api.nvim_set_hl(0, "FloatBorder", {
            fg = "#95B4D9",
            bg = "NONE"
        })
        vim.api.nvim_set_hl(0, "FloatTitle", {
            fg = "#95B4D9",
            bg = "NONE"
        })

        -- If you want to set a specific background color instead of transparent, you can do it like this:
        -- vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#cdd6f4", bg = "#313244" })
        -- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89b4fa", bg = "#313244" })

        require('neo-tree').setup({
            sources = {"filesystem", "buffers", "git_status"},
            source_selector = {
                winbar = true,
                statusline = true,
                sources = {{
                    source = "filesystem",
                    display_name = "  Files "
                }, {
                    source = "buffers",
                    display_name = "  Bufs"
                }, {
                    source = "git_status",
                    display_name = " Git"
                }}
            },
            filesystem = {
                follow_current_file = {
                    enabled = true -- Cập nhật theo cú pháp mới
                },
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = true, -- Hiển thị các tệp ẩn theo mặc định
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false,
                    hide_by_name = {"node_modules"},
                    never_show = {".DS_Store", "thumbs.db"}
                }
            },
            buffers = {
                follow_current_file = {
                    enabled = true -- Cập nhật theo cú pháp mới
                }
            },
            git_status = {
                window = {
                    position = "float"
                }
            },
            window = {
                position = "left",
                width = 30,
                mappings_options = {
                    noremap = true,
                    nowait = true
                }
            },
            -- separator_target = vim.api.nvim_win_get_width(0) * 0.1,
            default_component_configs = {
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                    folder_empty_open = ""
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified"
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "",
                        deleted = "",
                        modified = "",
                        renamed = "",
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "×",
                        staged = "",
                        conflict = ""
                    }
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true
                }
            },
            event_handlers = {{
                event = "neo_tree_window_after_open",
                handler = function(args)
                    vim.opt_local.fillchars:append({
                        eob = " "
                    })
                    if args.position == "left" or args.position == "right" then
                        vim.cmd("wincmd =")
                    end
                end
            }, {
                event = "neo_tree_window_after_close",
                handler = function(args)
                    if args.position == "left" or args.position == "right" then
                        vim.cmd("wincmd =")
                    end
                end
            }}
        })

        -- Thêm phím tắt Ctrl + N để toggle Neo-tree
        vim.keymap.set("n", "<C-n>", "<CMD>Neotree toggle<CR>", {
            noremap = true,
            silent = true
        })
    end
}
