return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    require("telescope").setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            results_width = 0.45,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
      pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
        colorscheme = {
          enable_preview = true, -- Preview theme khi di chuyển
          theme = "dropdown",
          layout_config = {
            width = 0.4,
            height = 0.5,
          },
          -- Lưu theme vào cache khi chọn
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              if selection then
                actions.close(prompt_bufnr)
                vim.cmd.colorscheme(selection.value)
                -- Lưu theme vào cache
                if _G.save_theme_to_cache then
                  _G.save_theme_to_cache(selection.value)
                  vim.notify("Theme saved: " .. selection.value, vim.log.levels.INFO)
                end
              end
            end)
            return true
          end,
        },
      },
    })

    -- File pickers
    vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>", { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>", { desc = "Commands" })
    vim.keymap.set("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>", { desc = "Recent files" })

    -- Theme picker
    vim.keymap.set("n", "<leader>th", "<CMD>Telescope colorscheme<CR>", { desc = "Choose theme" })

    -- Diagnostics (giống AstroNvim)
    vim.keymap.set("n", "<leader>ld", "<CMD>Telescope diagnostics bufnr=0<CR>", { desc = "Document Diagnostics" })
    vim.keymap.set("n", "<leader>lD", "<CMD>Telescope diagnostics<CR>", { desc = "Workspace Diagnostics" })

    -- LSP pickers
    vim.keymap.set("n", "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Document Symbols" })
    vim.keymap.set("n", "<leader>lS", "<CMD>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace Symbols" })
    vim.keymap.set("n", "<leader>lr", "<CMD>Telescope lsp_references<CR>", { desc = "References" })
    vim.keymap.set("n", "<leader>li", "<CMD>Telescope lsp_implementations<CR>", { desc = "Implementations" })
  end,
}
