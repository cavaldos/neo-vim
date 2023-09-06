local icons = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = "ﰠ ",
    Variable = " ",
    Class = "ﴯ ",
    Interface = " ",
    Module = " ",
    Property = "ﰠ ",
    Unit = "塞 ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = "פּ ",
    Event = " ",
    Operator = " ",
    TypeParameter = ""
}

-- custom aerial with icons
-- require("aerial").setup({
--   open_automatic = true,
--   float = {
--     border = "rounded",
--     relative = "cursor",
--     max_height = 0.9,
--     min_height = { 8, 0.1 },
--   },
--   icons = icons,
-- })

require("aerial").setup({
    attach_mode = "global",
    backends = {"lsp", "treesitter", "markdown", "man"},
    layout = {
        min_width = 28
    },
    show_guides = true,
    filter_kind = false,
    guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  "
    },
    keymaps = {
        ["[y"] = "actions.prev",
        ["]y"] = "actions.next",
        ["[Y"] = "actions.prev_up",
        ["]Y"] = "actions.next_up",
        ["{"] = false,
        ["}"] = false,
        ["[["] = false,
        ["]]"] = false
    }
})
