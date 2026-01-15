return {{
    "github/copilot.vim",
    config = function()
        -- Vô hiệu hóa keybinding mặc định của tab để tự map
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true

        -- Tab để accept Copilot suggestion, fallback về tab bình thường nếu không có suggestion
        vim.keymap.set("i", "<Tab>", function()
            local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
            if suggestion.text ~= "" then
                return vim.fn["copilot#Accept"]("")
            else
                return "\t"
            end
        end, { expr = true, silent = true, replace_keycodes = false })

        -- Ctrl+J làm backup cho Tab
        vim.keymap.set("i", "<C-J>", 'copilot#Accept("")', {
            expr = true,
            silent = true,
            replace_keycodes = false
        })
        vim.keymap.set("i", "<C-K>", 'copilot#Next()', {
            expr = true,
            silent = true
        })
        vim.keymap.set("i", "<C-H>", 'copilot#Previous()', {
            expr = true,
            silent = true
        })
        vim.keymap.set("i", "<C-L>", 'copilot#Dismiss()', {
            expr = true,
            silent = true
        })
    end
}}
