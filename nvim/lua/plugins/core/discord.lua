return {
  "andweeb/presence.nvim",
  event = "VimEnter",
  config = function()
    local presence = require("presence")

    presence.setup({
      neovim_image_text = "Neovim",
      main_image = "neovim",
      show_time = true,
      buttons = true,
      auto_update = true,
      debounce_timeout = 10,
      -- Tùy chỉnh thêm
      -- editing_text = "Editing %s",
      -- file_explorer_text = "Browsing %s",
      -- git_commit_text = "Committing changes",
      -- reading_text = "Reading %s",
    })

    -- Tự động reconnect khi focus vào Neovim
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        pcall(function()
          presence:cancel()
          presence:update()
        end)
      end,
    })

    -- Keymap để manual reconnect nếu cần
    vim.keymap.set("n", "<leader>dr", function()
      package.loaded.presence = nil
      presence = require("presence")
      presence.setup({
        neovim_image_text = "Neovim",
        main_image = "neovim",
        show_time = true,
        buttons = true,
        auto_update = true,
      })
      vim.notify("Discord presence reloaded!", vim.log.levels.INFO)
    end, { desc = "Reload Discord presence" })
  end,
}
