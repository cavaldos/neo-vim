return {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
        require("gitblame").setup({
            enabled = true,
            message_template = " <author> • <date> • <summary>",
            date_format = "%Y-%m-%d %H:%M",
            virtual_text_column = 80, -- Hiển thị ở cột 80
            delay = 300, -- Delay 300ms trước khi hiện
            highlight_group = "Comment", -- Màu giống comment
            set_extmark_options = {
                priority = 7,
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<cr>", { desc = "Toggle Git Blame" })
        vim.keymap.set("n", "<leader>go", "<cmd>GitBlameOpenCommitURL<cr>", { desc = "Open Commit URL" })
        vim.keymap.set("n", "<leader>gc", "<cmd>GitBlameCopyCommitURL<cr>", { desc = "Copy Commit URL" })
    end,
}
