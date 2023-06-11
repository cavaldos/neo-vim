-- Auto save view
vim.api.nvim_create_autocmd("BufWrite", {
    pattern = "*",
    command = "mkview"
})

-- Auto load view
vim.api.nvim_create_autocmd("BufRead", {
    pattern = "*",
    command = "silent! loadview"
})

-- Auto set tab file type
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = {
        "*.cs",
        "*.cshtml",
        "*.java",
        "*.lua",
        "*.python",
        "*.c",
        "*.cpp",
        "*.h",
        "*.xml",
        "*.gradle",
        "*.lua"
    },
    command = "setlocal tabstop=4 shiftwidth=4"
})

-- Auto trimspace
vim.api.nvim_create_autocmd("BufWrite", {
    pattern = "*",
    command = [[%s/\s\+$//e]]
})
