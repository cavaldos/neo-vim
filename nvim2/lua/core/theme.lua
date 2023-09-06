require("onedarkpro").setup({
    colors = {
        -- bg = "#1E222A"
        bg = "#1B1F26",
        red = "#E35D67",
        indentline = "#E25252",
        cyan = "#41B3DC",
        mycolor = "#16EE77"

    },
    highlights = {},
    filetypes = { -- Override which filetype highlight groups are loaded
        markdown = true,
        ruby = true
    },
    plugins = { -- Override which plugin highlight groups are loaded
        -- See the 'Supported plugins' section for the available list
    },
    styles = { -- For example, to apply bold and italic, use "bold,italic"
        types = "NONE", -- Style that is applied to types
        numbers = "NONE", -- Style that is applied to numbers
        strings = "NONE", -- Style that is applied to strings
        comments = "italic", -- Style that is applied to comments
        keywords = "bold,italic", -- Style that is applied to keywords
        constants = "NONE", -- Style that is applied to constants
        functions = "italic", -- Style that is applied to functions
        operators = "NONE", -- Style that is applied to operators
        variables = "NONE", -- Style that is applied to variables
        conditionals = "italic", -- Style that is applied to conditionals
        virtual_text = "NONE" -- Style that is applied to virtual text
    },

    options = {
        bold = true, -- Use bold styles?
        italic = true, -- Use italic styles?
        underline = true, -- Use underline styles?
        undercurl = true, -- Use undercurl styles?

        cursorline = true, -- Use cursorline highlighting?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?

        transparency = false, -- Bật tính năng trong suốt

        background = {
            -- light = "0.9", -- Độ trong suốt ở chế độ light
            -- dark = "0.9", -- Độ trong suốt ở chế độ dark 

        }

    }
})

vim.cmd("colorscheme onedark ")
