require("lualine").setup({
    options = {
        component_separators = {},
        section_separators = {},
        theme = "auto",
        ignore_focus = {"NvimTree"}
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff"},
        lualine_c = {"filename", "diagnostics"},
        lualine_x = {"filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
    },
    inactive_sections = {}
})
