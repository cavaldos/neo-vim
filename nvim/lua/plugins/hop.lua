return {
  "hadronized/hop.nvim",
  config = function()
    require("hop").setup()
    vim.keymap.set("n", "<leader><leader>f", "<CMD>HopWord<CR>")
    vim.keymap.set("n", "<leader><leader>s", "<CMD>HopChar1<CR>")
    vim.keymap.set("n", "<leader><leader>/", "<CMD>HopPattern<CR>")
    vim.keymap.set("n", "<leader><leader>j", "<CMD>HopLineStartAC<CR>")
    vim.keymap.set("n", "<leader><leader>k", "<CMD>HopLineStartBC<CR>")
  end,
}
