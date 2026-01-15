return {
  {
    "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    "junegunn/fzf.vim",
    config = function()
      -- Đặt các phím tắt cho fzf.vim
      vim.api.nvim_set_keymap("n", "<leader>fz", ":Files<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>g", ":Rg<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>b", ":Buffers<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>h", ":History<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>l", ":BLines<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>t", ":Tags<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>m", ":Marks<CR>", { noremap = true, silent = true })
    end,
  },
}
