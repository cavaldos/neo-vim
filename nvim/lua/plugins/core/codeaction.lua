return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
    event = "LspAttach",
    opts = {
        -- Backend: "vim", "delta", "difftastic", "diffsofancy"
        backend = "vim",

        -- Picker: "telescope", "snacks", "select", "buffer", "fzf-lua"
        picker = {
            "buffer",
            opts = {
                hotkeys = true,
                hotkeys_mode = "text_diff_based",
                auto_preview = false,
                auto_accept = false,
                position = "cursor",
                winborder = "single",
                keymaps = {
                    preview = "K",
                    close = { "q", "<Esc>" },
                    select = "<CR>",
                    preview_close = { "q", "<Esc>" },
                },
                custom_keys = {
                    { key = "m", pattern = "Fill match arms" },
                    { key = "r", pattern = "Rename.*" },
                },
                group_icon = " └",
            },
        },

        backend_opts = {
            delta = {
                header_lines_to_remove = 4,
                args = {
                    "--line-numbers",
                },
            },
            difftastic = {
                header_lines_to_remove = 1,
                args = {
                    "--color=always",
                    "--display=inline",
                    "--syntax-highlight=on",
                },
            },
            diffsofancy = {
                header_lines_to_remove = 4,
            },
        },

        resolve_timeout = 100,

        notify = {
            enabled = true,
            on_empty = true,
        },

        format_title = nil,

        signs = {
            quickfix = { "", { link = "DiagnosticWarning" } },
            others = { "", { link = "DiagnosticWarning" } },
            refactor = { "", { link = "DiagnosticInfo" } },
            ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
            ["refactor.extract"] = { "", { link = "DiagnosticError" } },
            ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
            ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
            ["source"] = { "", { link = "DiagnosticError" } },
            ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
            ["codeAction"] = { "", { link = "DiagnosticWarning" } },
        },
    },
}
