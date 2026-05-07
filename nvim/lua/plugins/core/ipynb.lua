local function hasTreeSitterCli()
  return vim.fn.executable("tree-sitter") == 1
end

local function hasSnacksImages()
  local ok, snacks = pcall(require, "snacks")
  if not ok or type(snacks) ~= "table" or type(snacks.image) ~= "table" then
    return false
  end

  if type(snacks.image.supports_terminal) ~= "function" then
    return false
  end

  local okSupports, supported = pcall(snacks.image.supports_terminal)
  return okSupports and supported == true
end

return {
  "ajbucci/ipynb.nvim",
  enabled = hasTreeSitterCli(),
  cond = hasTreeSitterCli,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
    "nvim-tree/nvim-web-devicons",
    -- "folke/snacks.nvim", -- optional, for inline images
  },
  init = function()
    if hasTreeSitterCli() then
      return
    end

    vim.api.nvim_create_autocmd("BufReadPre", {
      pattern = "*.ipynb",
      callback = function()
        vim.schedule(function()
          vim.notify(
            "ipynb.nvim is disabled because the 'tree-sitter' CLI is not installed. Install it to enable notebook support.",
            vim.log.levels.WARN,
            { title = "ipynb.nvim" }
          )
        end)
      end,
    })
  end,
  opts = function()
    return {
      border_hints = {
        enabled = true,
        show_on_hover = true,
        show_on_edit = true,
      },
      folding = {
        hide_output = false,
      },
      format = {
        enabled = true,
        trailing_blank_lines = 0,
      },
      highlights = {
        border = "FloatBorder",
        border_hover = "CursorLineNr",
        border_active = "DiagnosticInfo",
        exec_count = "Number",
        output = "Comment",
        hint = "DiagnosticHint",
        output_error = "DiagnosticError",
        executing = "DiagnosticWarn",
        queued = "DiagnosticHint",
      },
      images = {
        enabled = hasSnacksImages(),
        cache_dir = vim.fn.stdpath("cache") .. "/ipynb.nvim",
        max_width = nil,
        max_height = nil,
      },
      inspector = {
        close = { "q", "<Esc>" },
        inspect = { "K", "<CR>" },
        auto_hover = {
          enabled = true,
          delay = 350,
        },
      },
      kernel = {
        auto_connect = false,
        show_status = true,
        python_path = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. "/bin/python") or nil,
      },
      shadow = {
        location = "workspace",
        dir = ".ipynb.nvim",
      },
    }
  end,
}
