return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("ibl").setup({
            indent = {
                char = "│"
            }, -- Ký tự hiển thị indent (hoặc ▏, ┆)
            scope = {
                enabled = true, -- Hiển thị viền indent khi focus vào khối lệnh
                show_start = false, -- Hiển thị viền bắt đầu khối
                show_end = false, -- Không hiển thị đường kết thúc
                highlight = "Function" -- Màu sắc cho đường viền scope
            }
        })

    end
}
