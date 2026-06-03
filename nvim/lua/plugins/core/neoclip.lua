return {
  "AckslD/nvim-neoclip.lua",

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>y", "<cmd>Telescope neoclip<cr>", desc = "Clipboard history" },
  },
  config = function()
    local neoclip = require("neoclip")
    local telescope = require("telescope")

    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    neoclip.setup()

    telescope.setup({
      extensions = {
        neoclip = {
          mappings = {
            i = {
              ["<CR>"] = function(prompt_bufnr)
                local entry = action_state.get_selected_entry()

                if entry then
                  local value = entry.value[1]

                  vim.fn.setreg("+", value)
                  vim.fn.setreg('"', value)

                  print("Copied: " .. value)
                end

                actions.close(prompt_bufnr)
              end,
            },

            n = {
              ["<CR>"] = function(prompt_bufnr)
                local entry = action_state.get_selected_entry()

                if entry then
                  local value = entry.value[1]

                  vim.fn.setreg("+", value)
                  vim.fn.setreg('"', value)

                  print("Copied: " .. value)
                end

                actions.close(prompt_bufnr)
              end,
            },
          },
        },
      },
    })

    telescope.load_extension("neoclip")
  end,
}
