return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "Hoffs/omnisharp-extended-lsp.nvim",
  },
  config = function()
    require("mason-lspconfig").setup()

    local handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup({
          handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
          },
        })
      end,
      ["omnisharp"] = function()
        require("lspconfig").omnisharp.setup({
          handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
            ["textDocument/references"] = require("omnisharp_extended").references_handler,
            ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
          },
        })
      end,
    }

    require("mason-lspconfig").setup_handlers(handlers)
  end,
}
