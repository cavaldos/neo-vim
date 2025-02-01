return {{
    "github/copilot.vim",
    config = function()
        -- Vô hiệu hóa keybinding mặc định của tab
        vim.g.copilot_no_tab_map = false
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_tab_fallback = "  "

        -- Thiết lập keybindings tùy chọn của bạn
        vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', {
            silent = true,
            expr = true
        })
        vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next()', {
            silent = true,
            expr = true
        })
        vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Previous()', {
            silent = true,
            expr = true
        })
        vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Dismiss()', {
            silent = true,
            expr = true
        })
    end
}}
