return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    -- Add Mason bin to PATH so LSP servers can be found
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd",        -- C/C++
        "rust_analyzer", -- Rust
        "ts_ls",         -- JavaScript/TypeScript/React
        "eslint",        -- ESLint for React/TypeScript
        "pyright",       -- Python
        "html",          -- HTML
        "cssls",         -- CSS
        "lua_ls",        -- Lua
      },
      automatic_installation = true,
    })

    -- Neovim 0.11+ API: dùng vim.lsp.enable() thay vì lspconfig[server].setup()
    vim.lsp.enable({
      "clangd",
      "rust_analyzer",
      "ts_ls",
      "eslint",
      "pyright",
      "html",
      "cssls",
      "lua_ls",
      "sourcekit",
    })
  end,
}
