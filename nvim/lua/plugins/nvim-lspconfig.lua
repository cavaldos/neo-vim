return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        lspconfig.tsserver.setup({
            on_attach = function(client, bufnr)
                -- Thiết lập phím tắt khi LSP attach vào buffer
                local opts = {
                    buffer = bufnr,
                    noremap = true,
                    silent = true
                }
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                -- Hiển thị icon lỗi, cảnh báo
                local signs = {
                    Error = "",
                    Warn = "",
                    Hint = "",
                    Info = ""
                }
                for type, icon in pairs(signs) do
                    local hl = "DiagnosticSign" .. type
                    vim.fn.sign_define(hl, {
                        text = icon,
                        texthl = hl
                    })
                end

                -- Cấu hình hiển thị chẩn đoán (diagnostics)
                vim.diagnostic.config({
                    virtual_text = {
                        prefix = "",
                        spacing = 4
                    },
                    signs = true,
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                    float = {
                        border = "rounded",
                        source = "always"
                    }
                })
            end
        })

    end
}
