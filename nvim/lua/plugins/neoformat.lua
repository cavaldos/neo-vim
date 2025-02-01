return {{
    "sbdchd/neoformat",
    config = function()
        -- Cài đặt neoformat
        vim.g.neoformat_try_node_exe = 1

        -- Đặt keybinding để định dạng thủ công
        vim.api.nvim_set_keymap("n", "<D-f>", ":Neoformat<CR>", {
            noremap = true,
            silent = true
        })

        -- Thiết lập tự động định dạng khi lưu file
        vim.cmd([[
        augroup fmt
          autocmd!
          autocmd BufWritePre * undojoin | Neoformat
        augroup END
      ]])

        -- Cấu hình các định dạng tùy chỉnh (tuỳ chọn)
        vim.g.neoformat_enabled_javascript = {'prettier'}
        vim.g.neoformat_enabled_typescript = {'prettier'}
        vim.g.neoformat_enabled_css = {'prettier'}
        vim.g.neoformat_enabled_json = {'prettier'}
    end
}}
