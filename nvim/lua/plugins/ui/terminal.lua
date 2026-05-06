return {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    cmd = "FloatermToggle",
    keys = {
        { "<F1>", "<cmd>FloatermToggle<cr>", mode = { "n", "t" } },
    },
    opts = {
        border = false,
        size = { h = 60, w = 70 },

        -- 2 terminal mặc định
        terminals = {
            { name = "Terminal 1" },
            { name = "Terminal 2" },
        },

        mappings = {
            term = function(buf)
                -- Chuyển sang terminal trước
                vim.keymap.set({ "n", "t" }, "<C-p>", function()
                    require("floaterm.api").cycle_term_bufs "prev"
                end, { buffer = buf })

                -- Chuyển sang terminal tiếp theo
                vim.keymap.set({ "n", "t" }, "<C-n>", function()
                    require("floaterm.api").cycle_term_bufs "next"
                end, { buffer = buf })
            end,
        },
    },
}