return {
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true, -- Kích hoạt hỗ trợ cho cây cú pháp (treesitter)
            ts_config = {
                lua = {'string'}, 
                javascript = {'template_string'}, 
                java = false 
            },
            disable_filetype = {"TelescopePrompt", "vim"}
        })
  
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        local npairs = require('nvim-autopairs')
        npairs.setup({
            map_cr = true, -- Tự động thêm dấu ngoặc kép khi nhấn Enter
            map_complete = true, -- Tự động thêm dấu ngoặc kép khi hoàn thành từ với nvim-cmp
            map_char = {
                all = '(',
                tex = '{'
            }
            
        })

    end
}
