return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local builtin = require("telescope.builtin")

    local function in_git_repo(cwd)
      local git_dir = vim.fn.finddir(".git", cwd .. ";")
      if git_dir ~= "" then
        return true
      end

      local result = vim.fn.system({ "git", "-C", cwd, "rev-parse", "--is-inside-work-tree" })
      return vim.v.shell_error == 0 and vim.trim(result) == "true"
    end

    local function notify_not_git_repo()
      vim.notify("This folder is not a git repository", vim.log.levels.WARN)
    end

    local function safe_git_picker(git_picker, fallback_picker)
      return function(opts)
        local cwd = (opts and opts.cwd) or vim.loop.cwd() or vim.fn.getcwd()

        if in_git_repo(cwd) then
          return git_picker(opts)
        end

        if fallback_picker then
          vim.notify("Not in a git repository, using regular picker instead", vim.log.levels.INFO)
          return fallback_picker(opts)
        end

        notify_not_git_repo()
      end
    end

    builtin.git_files = safe_git_picker(builtin.git_files, builtin.find_files)
    builtin.git_status = safe_git_picker(builtin.git_status)
    builtin.git_commits = safe_git_picker(builtin.git_commits)
    builtin.git_bcommits = safe_git_picker(builtin.git_bcommits)
    builtin.git_branches = safe_git_picker(builtin.git_branches)
    builtin.git_stash = safe_git_picker(builtin.git_stash)

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
          enable_preview = true,
          theme = "dropdown",
          layout_config = {
            width = 0.4,
            height = 0.5,
          },
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              if selection then
                actions.close(prompt_bufnr)
                vim.cmd.colorscheme(selection.value)
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

    local git_files = safe_git_picker(builtin.git_files, builtin.find_files)
    local git_status = safe_git_picker(builtin.git_status)
    local git_commits = safe_git_picker(builtin.git_commits)
    local git_bcommits = safe_git_picker(builtin.git_bcommits)
    local git_branches = safe_git_picker(builtin.git_branches)
    local git_stash = safe_git_picker(builtin.git_stash)

    -- File pickers
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
    vim.keymap.set("n", "<leader>fF", git_files, { desc = "Git files or files" })

    -- Git pickers
    vim.keymap.set("n", "<leader>gs", git_status, { desc = "Git status" })
    vim.keymap.set("n", "<leader>gC", git_commits, { desc = "Git commits" })
    vim.keymap.set("n", "<leader>gc", git_bcommits, { desc = "Buffer commits" })
    vim.keymap.set("n", "<leader>gb", git_branches, { desc = "Git branches" })
    vim.keymap.set("n", "<leader>gS", git_stash, { desc = "Git stash" })

    -- Theme picker
    vim.keymap.set("n", "<leader>th", builtin.colorscheme, { desc = "Choose theme" })

    -- Diagnostics
    vim.keymap.set("n", "<leader>ld", function()
      builtin.diagnostics({ bufnr = 0 })
    end, { desc = "Document Diagnostics" })
    vim.keymap.set("n", "<leader>lD", builtin.diagnostics, { desc = "Workspace Diagnostics" })

    -- LSP pickers
    vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Document Symbols" })
    vim.keymap.set("n", "<leader>lS", builtin.lsp_workspace_symbols, { desc = "Workspace Symbols" })
    vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "References" })
    vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, { desc = "Implementations" })
  end,
}
