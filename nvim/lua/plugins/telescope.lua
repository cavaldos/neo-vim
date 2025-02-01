return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("telescope").setup()
    vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
    vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
    vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
    vim.keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>")
  end,
}
