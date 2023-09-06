require('nvim-autopairs').setup {}
-- Kích hoạt nui.nvim

-- Mở rộng để hiển thị file ẩn
require("neo-tree").setup({
    show_hidden = true
})
-- Bật hiển thị file ẩn trong Neovim
vim.cmd [[set hidden]]
