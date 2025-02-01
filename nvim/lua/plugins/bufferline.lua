return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "moll/vim-bbye",
  },
  config = function()
    require("bufferline").setup({
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    })

    vim.keymap.set("n", "<A-.>", "<CMD>BufferLineCycleNext<CR>")
    vim.keymap.set("n", "<A-,>", "<CMD>BufferLineCyclePrev<CR>")
    vim.keymap.set("n", "<A->>", "<CMD>BufferLineMoveNext<CR>")
    vim.keymap.set("n", "<A-<>", "<CMD>BufferLineMovePrev<CR>")
    vim.keymap.set("n", "<A-c>", "<CMD>Bdelete<CR>")
  end,
}
