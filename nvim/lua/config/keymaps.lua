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
