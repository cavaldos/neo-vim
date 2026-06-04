return {
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            -- remember to set keymaps for accepting and clearing suggestions
            -- Copilot: <Tab>, <C-J>, <C-K>, <C-H>, <C-L>
            -- Supermaven: <C-]>, <C-\>, <A-]>
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<C-]>",
                    clear_suggestion = "<C-\\>",
                    accept_word = "<A-]>",
                },
                ignore_filetypes = {
                    -- thêm filetype muốn tắt supermaven tại đây
                    -- ví dụ: markdown = true
                },
                color = {
                    -- Màu suggestion (grayer hơn Copilot một chút để phân biệt)
                    suggestion_color = "#7c7c7c",
                    cterm = 244,
                },
                log_level = "info", -- "off" để tắt logging
                disable_inline_completion = false,
                disable_keymaps = false,
            })
        end
    }
}
