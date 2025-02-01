return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            stages = "fade_in_slide_out", -- Hoặc "fade_in_slide_out", "fade", "static"
            render = "compact", -- Hoặc "slide"
            timeout = 3000, -- Thời gian hiển thị (ms)
            background_colour = "#1E1E2E", -- Màu nền
            max_width = 50,
            max_height = 10,
            fps = 60
        })

        -- Đặt notify làm hệ thống thông báo mặc định của Neovim
        vim.notify = require("notify")

        -- Thêm phím tắt để hiển thị lịch sử thông báo
        vim.keymap.set("n", "<leader>nh", "<CMD>Notifications<CR>", {
            noremap = true,
            silent = true
        })
    end
}