return {
  {
    "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    "junegunn/fzf.vim",
    config = function()
      local map = function(key, cmd)
        vim.api.nvim_set_keymap("n", "<leader>" .. key, cmd, { noremap = true, silent = true })
      end

      -- Files & Search
      map("zf", ":Files<CR>")          -- Tìm file trong project
      map("zg", ":Rg<CR>")             -- Grep toàn project (ripgrep)
      map("zG", ":GFiles<CR>")         -- Chỉ file được git track
      map("zs", ":GFiles?<CR>")        -- File git status (modified/staged)
      map("za", ":Ag<CR>")             -- Grep bằng ag (silver searcher)

      -- Buffers & History
      map("zb", ":Buffers<CR>")        -- Danh sách buffer đang mở
      map("zh", ":History<CR>")        -- File đã mở gần đây
      map("z;", ":History:<CR>")       -- Lịch sử lệnh command-line
      map("z/", ":History/<CR>")       -- Lịch sử tìm kiếm

      -- Lines & Tags
      map("zl", ":BLines<CR>")         -- Tìm dòng trong buffer hiện tại
      map("zz", ":Lines<CR>")          -- Tìm dòng trong tất cả buffer
      map("zt", ":Tags<CR>")           -- Tags toàn project (ctags)
      map("zT", ":BTags<CR>")          -- Tags chỉ trong buffer hiện tại

      -- Vim internals
      map("zm", ":Marks<CR>")          -- Danh sách marks
      map("zq", ":Quickfix<CR>")       -- Quickfix list
      map("zw", ":Windows<CR>")        -- Danh sách window đang mở
      map("zj", ":Jumps<CR>")          -- Jump list
      map("zc", ":Changes<CR>")        -- Change list
      map("ze", ":Locate .<CR>")       -- Tìm file bằng locate (toàn hệ thống)

      -- Vim config
      map("zk", ":Maps<CR>")           -- Xem tất cả keymaps hiện tại
      map("zo", ":Commands<CR>")       -- Danh sách tất cả commands
      map("zn", ":Snippets<CR>")       -- Snippets (cần UltiSnips)
      map("zC", ":Colors<CR>")         -- Chọn colorscheme
      map("zF", ":Filetypes<CR>")      -- Chọn filetype
      map("zH", ":Helptags<CR>")       -- Tìm trong help docs
    end,
  },
}