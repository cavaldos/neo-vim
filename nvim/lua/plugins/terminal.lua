return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<D-,>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- Thiết lập phím tắt cho Command + ,
      vim.api.nvim_set_keymap("n", "<D-,>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("i", "<D-,>", "<Esc><cmd>ToggleTerm<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("t", "<D-,>", "<C-\\><C-n><cmd>ToggleTerm<CR>", { noremap = true, silent = true })
    end,
  },
}
