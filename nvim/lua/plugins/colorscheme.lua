return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_foreground = "original"
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
    vim.g.gruvbox_material_enable_bold = true
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_diagnostic_text_highlight = true
    vim.g.gruvbox_material_diagnostic_line_highlight = true
    vim.g.gruvbox_material_transparent_background = true
    vim.g.gruvbox_material_better_performance = true
    vim.cmd.colorscheme("gruvbox-material")
    vim.api.nvim_set_hl(0, "CursorLine", { fg = "none", bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineNR", { fg = "orange", bold = true })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  end,
}
