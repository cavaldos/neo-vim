return {
    "lewis6991/gitsigns.nvim",
    event = {"BufReadPre", "BufNewFile"}, -- lazy load
    config = function()
        require("gitsigns").setup({
            vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", {
                fg = "#6C7378", -- gray
                bold = true,
                italic = true
            }),

            -- Show signs
            signs = {
                add = {
                    text = "▎"
                },
                change = {
                    text = "▎"
                },
                delete = {
                    text = ""
                },
                topdelete = {
                    text = ""
                },
                changedelete = {
                    text = "▎"
                },
                untracked = {
                    text = "▎"
                }
            },

            -- Show signs when file staged (git add)
            signs_staged = {
                add = {
                    text = "▎"
                },
                change = {
                    text = "▎"
                },
                delete = {
                    text = ""
                },
                topdelete = {
                    text = ""
                },
                changedelete = {
                    text = "▎"
                }
            },
            signs_staged_enable = true,

            -- Behavior
            signcolumn = true, -- Always show signcolumn, avoid shifting text
            numhl = true, -- Highlight line number
            linehl = false, -- Highlight entire line
            word_diff = false, -- Highlight word changes
            watch_gitdir = {
                follow_files = true -- Auto refresh signs when files change in git dir (e.g. git add)
            },

            auto_attach = true, -- Auto attach to git repo when opening file
            attach_to_untracked = true, -- Attach to untracked files (not in git repo yet)

            current_line_blame = true, -- Show blame inline at current line
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
                ignore_whitespace = false,
                virt_text_priority = 100
            },
            current_line_blame_formatter = "               <author> • <author_time:%Y-%m-%d %H:%M> • <summary>",

            current_line_blame_formatter_nc = "               <author> • <author_time:%Y-%m-%d %H:%M> • <summary>",

            sign_priority = 6, -- Priority of signs (default 10)
            update_debounce = 100, -- ms debounce for updating signs
            status_formatter = nil, -- Use default status formatter (format info in statusline)
            max_file_length = 40000, -- Disable signs for files longer than this (in lines) to improve performance
            preview_config = { -- Options for gitsigns preview hunk
                border = "rounded",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1
            },

            -- ─── Keymaps ────────────────────────────────────────────────────────
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, {
                        buffer = bufnr,
                        desc = desc
                    })
                end

                -- Điều hướng hunk
                map("n", "]h", function()
                    if vim.wo.diff then
                        return "]h"
                    end
                    vim.schedule(gs.next_hunk)
                    return "<Ignore>"
                end, "Next hunk")

                map("n", "[h", function()
                    if vim.wo.diff then
                        return "[h"
                    end
                    vim.schedule(gs.prev_hunk)
                    return "<Ignore>"
                end, "Prev hunk")

                -- Staging
                map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
                map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
                map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
                map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
                map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

                -- Preview & Blame
                map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>hP", gs.preview_hunk_inline, "Preview hunk inline")
                map("n", "<leader>hb", function()
                    gs.blame_line({
                        full = true
                    })
                end, "Blame line (full)")
                map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

                -- Diff
                map("n", "<leader>hd", gs.diffthis, "Diff this")
                map("n", "<leader>hD", function()
                    gs.diffthis("~")
                end, "Diff this ~")

                -- Toggles
                map("n", "<leader>td", gs.toggle_deleted, "Toggle deleted")
                map("n", "<leader>tw", gs.toggle_word_diff, "Toggle word diff")
                map("n", "<leader>tn", gs.toggle_numhl, "Toggle numhl")
                map("n", "<leader>tl", gs.toggle_linehl, "Toggle linehl")
                map("n", "<leader>ts", gs.toggle_signs, "Toggle signs")

                -- Text objects (chọn hunk trong visual/operator mode)
                map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
            end
        })
    end
}
