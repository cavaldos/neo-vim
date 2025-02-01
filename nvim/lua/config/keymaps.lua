--sysmtem keymaps
vim.api.nvim_set_keymap("n", "<D-z>", "u", {
  noremap = true,
})
vim.api.nvim_set_keymap("n", "<D-S-Z>", "<C-r>", {
  noremap = true,
})

-- Đặt phím <leader> là dấu phẩy
--
vim.g.mapleader = ","
