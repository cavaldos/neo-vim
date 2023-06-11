-- Setup language servers.
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local servers = {
    "html",
    "cssls",
    "emmet_ls",
    "lua_ls",
    "tsserver",
    "bashls",
    "jsonls",
    "tailwindcss",
    "pyright",
    "csharp_ls",
    "clangd",


}

for _, server in pairs(servers) do
    lspconfig[server].setup({
        handlers = handlers,
        capabilities = capabilities
    })
end
