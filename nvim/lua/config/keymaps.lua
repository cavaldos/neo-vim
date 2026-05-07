--sysmtem keymaps
vim.api.nvim_set_keymap("n", "<D-z>", "u", {
  noremap = true,
})
vim.api.nvim_set_keymap("n", "<D-S-Z>", "<C-r>", {
  noremap = true,
})

-- Đặt phím <leader> là dấu phẩy
--
vim.g.mapleader = ","

-- Click vào Sign Column (cột icon lỗi) để mở Telescope Diagnostics
vim.keymap.set("n", "<LeftMouse>", function()
  -- Thực hiện click bình thường trước
  local keys = vim.api.nvim_replace_termcodes("<LeftMouse>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)

  -- Delay nhỏ để đảm bảo click đã xử lý
  vim.defer_fn(function()
    local mousepos = vim.fn.getmousepos()
    local wininfo = vim.fn.getwininfo(mousepos.winid)

    if wininfo and wininfo[1] then
      local textoff = wininfo[1].textoff
      if mousepos.wincol <= textoff then
        local line = mousepos.line - 1
        local diagnostics = vim.diagnostic.get(0, { lnum = line })

        if #diagnostics > 0 then
          vim.cmd("Telescope diagnostics bufnr=0")
        end
      end
    end
  end, 10)
end, { desc = "Click sign column to open diagnostics" })


-- Copy messages to clipboard
vim.keymap.set('n', '<leader>cm', function()
  vim.cmd('redir @+ | messages | redir END')
  print("✓ Copied messages to clipboard")
end, { desc = 'Copy messages to clipboard' })

-- Toggle background transparency (xóa màu background, hiện màu system)
vim.keymap.set('n', '<leader>tb', function()
  if vim.g.transparent_bg then
    -- Restore background colors
    vim.api.nvim_set_hl(0, "Normal", { bg = vim.g.original_bg })
    vim.g.transparent_bg = false
    print("Background: ON")
  else
    -- Store original background and set to transparent
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "Normal", link = false })
    vim.g.original_bg = ok and hl.bg or nil
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.g.transparent_bg = true
    print("Background: OFF (system colors)")
  end
end, { desc = 'Toggle background transparency' })

-- Telescope theme picker 
vim.keymap.set("n", "<leader>tn", "<cmd>Telescope themes<cr>", { desc = "Choose theme" })

-- Buffer navigation
vim.keymap.set("n", "L", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "H", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>uh", "<cmd>nohlsearch<CR>")
