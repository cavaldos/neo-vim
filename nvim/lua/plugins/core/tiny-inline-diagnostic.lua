return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Load when LSP attaches
    priority = 1000,
    config = function()
        -- Disable Neovim's default virtual text FIRST
        vim.diagnostic.config({ virtual_text = false })

        require("tiny-inline-diagnostic").setup({
            -- Style preset: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
            preset = "modern",

            -- Transparent background
            transparent_bg = false,
            transparent_cursorline = true,

            -- Highlight groups
            hi = {
                error = "DiagnosticError",
                warn = "DiagnosticWarn",
                info = "DiagnosticInfo",
                hint = "DiagnosticHint",
                arrow = "NonText",
                background = "CursorLine",
                mixing_color = "Normal",
            },

            -- Filetypes to disable
            disabled_ft = {},

            options = {
                -- Show source of diagnostic (e.g., "lua_ls", "pyright")
                show_source = {
                    enabled = true,
                    if_many = true,
                },

                -- Use icons from vim.diagnostic.config
                use_icons_from_diagnostic = false,

                -- Arrow color matches severity
                set_arrow_to_diag_color = true,

                -- Throttle for performance
                throttle = 20,

                -- Minimum chars before wrapping
                softwrap = 30,

                -- Message display options
                add_messages = {
                    messages = true,
                    display_count = false,
                    use_max_severity = false,
                    show_multiple_glyphs = true,
                },

                -- Multiline diagnostic support
                multilines = {
                    enabled = true,
                    always_show = false,
                    trim_whitespaces = true,
                    tabstop = 4,
                    severity = nil,
                },

                -- Show all diagnostics on cursor line
                show_all_diags_on_cursorline = true,

                -- Show related diagnostics
                show_related = {
                    enabled = true,
                    max_count = 3,
                },

                -- Disable in insert mode
                enable_on_insert = false,
                enable_on_select = false,

                -- Overflow handling
                overflow = {
                    mode = "wrap",
                    padding = 0,
                },

                -- Line breaking
                break_line = {
                    enabled = false,
                    after = 30,
                },

                -- Virtual text priority (higher = above other plugins)
                virt_texts = {
                    priority = 2048,
                },

                -- Severity levels to display
                severity = {
                    vim.diagnostic.severity.ERROR,
                    vim.diagnostic.severity.WARN,
                    vim.diagnostic.severity.INFO,
                    vim.diagnostic.severity.HINT,
                },
            },
        })

        -- Keymaps for toggle
        vim.keymap.set("n", "<leader>dt", "<cmd>TinyInlineDiag toggle<cr>", { desc = "Toggle inline diagnostics" })
    end,
}
