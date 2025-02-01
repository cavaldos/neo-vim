return {
    "hrsh7th/nvim-cmp",
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-vsnip",
                    "hrsh7th/vim-vsnip", "onsails/lspkind.nvim", "luckasRanarison/tailwind-tools.nvim",
                    "onsails/lspkind-nvim"},
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = true
                })
            }),
            sources = cmp.config.sources({{
                name = "nvim_lsp"
            }, {
                name = "buffer"
            }, {
                name = "path"
            }, {
                name = "vsnip"
            }, {
                name = "tailwind-tools"
            }}),
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    before = require("tailwind-tools.cmp").lspkind_format
                })
            }
        })
    end
}
