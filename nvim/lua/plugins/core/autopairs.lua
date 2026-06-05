return {
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true, -- Kích hoạt hỗ trợ cho cây cú pháp (treesitter)
            ts_config = {
                lua = {'string'},
                javascript = {'template_string'},
                java = false
            },
            disable_filetype = {"TelescopePrompt", "vim"},

            -- blink.cmp: không cần gọi cmp.event:on, chỉ cần map_complete
            map_cr = true,      -- Tự động thêm dấu ngoặc kép khi nhấn Enter
            map_complete = true, -- Tự động thêm dấu ngoặc khi hoàn thành từ với blink.cmp
            map_char = {
                all = '(',
                tex = '{'
            }
        })
    end
}
