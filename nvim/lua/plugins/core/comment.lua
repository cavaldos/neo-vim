return {{
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            -- Cấu hình phím tắt
            mappings = {
                basic = true, -- Bật phím tắt cơ bản
                extra = true -- Bật phím tắt mở rộng
            }
        })

        -- **Cấu hình phím tắt cho Comment**
        local api = require("Comment.api")
        vim.keymap.set("n", "<C-/>", api.toggle.linewise.current, {
            noremap = true,
            silent = true
        }) -- Comment dòng hiện tại
        vim.keymap.set("v", "<C-/>", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {
            noremap = true,
            silent = true
        }) -- Comment khối
        vim.keymap.set("n", "<leader>cc", api.toggle.linewise.current, {
            noremap = true,
            silent = true
        }) -- Comment/uncomment dòng
        vim.keymap.set("v", "<leader>cc",
            "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {
                noremap = true,
                silent = true
            }) -- Comment/uncomment khối
        vim.keymap.set("n", "<leader>cb", api.toggle.blockwise.current, {
            noremap = true,
            silent = true
        }) -- Comment/uncomment kiểu block (/* */)
        vim.keymap.set("v", "<leader>cb",
            "<ESC><CMD>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>", {
                noremap = true,
                silent = true
            }) -- Comment/uncomment block khối
    end
}}
