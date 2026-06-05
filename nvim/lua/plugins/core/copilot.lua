return {{
    "github/copilot.vim",
    config = function()
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true

        local function has_suggestion()
            return vim.fn["copilot#GetDisplayedSuggestion"]().text ~= ""
        end

        -- Tab: accept 1 line
        vim.keymap.set("i", "<Tab>", function()
            if has_suggestion() then
                return vim.fn["copilot#AcceptLine"]("")
            else
                return "\t"
            end
        end, { expr = true, silent = true, replace_keycodes = false })

        -- Ctrl+\\: accept full suggestion
        vim.keymap.set("i", "<C-\\>", function()
            if has_suggestion() then
                return vim.fn["copilot#Accept"]("")
            else
                return "\n"
            end
        end, { expr = true, silent = true, replace_keycodes = false })

        -- Ctrl+;: next suggestion, Ctrl+': previous suggestion
        vim.keymap.set("i", "<C-;>", 'copilot#Next()', {
            expr = true, silent = true
        })
        vim.keymap.set("i", "<C-'>", 'copilot#Previous()', {
            expr = true, silent = true
        })

        -- Ctrl+L: dismiss
        vim.keymap.set("i", "<C-/>", 'copilot#Dismiss()', {
            expr = true, silent = true
        })
    end
}}