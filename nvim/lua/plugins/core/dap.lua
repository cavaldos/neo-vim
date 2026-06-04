local function executable(name)
  return vim.fn.executable(name) == 1
end

local function mason_package_path(package)
  return vim.fn.stdpath("data") .. "/mason/packages/" .. package
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap-python",
    },
    lazy = false,
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("nvim-dap-virtual-text").setup()

      dapui.setup()

      local function open_dap_ui()
        dapui.open()
        vim.notify("DAP UI opened", vim.log.levels.INFO)
      end

      dap.listeners.before.attach.dapui_config = open_dap_ui
      dap.listeners.before.launch.dapui_config = open_dap_ui

      -- Keep the debug UI open after the program exits so fast-running
      -- scripts do not close the layout before you can inspect output.

      require("mason-nvim-dap").setup({
        ensure_installed = {
          "codelldb",
          "debugpy",
          "js-debug-adapter",
        },
        automatic_installation = true,
        handlers = {},
      })

      local debugpy_python = mason_package_path("debugpy") .. "/venv/bin/python"
      if executable(debugpy_python) then
        require("dap-python").setup(debugpy_python)
      else
        require("dap-python").setup("python3")
      end

      local js_debug_path = mason_package_path("js-debug-adapter") .. "/js-debug/src/dapDebugServer.js"
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { js_debug_path, "${port}" },
        },
      }

      for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch current file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
          },
        }
      end

      local codelldb_adapter = mason_package_path("codelldb") .. "/extension/adapter/codelldb"
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_adapter,
          args = { "--port", "${port}" },
        },
      }

      local compiled_program_config = {
        type = "codelldb",
        request = "launch",
        name = "Launch executable",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      }

      dap.configurations.rust = { compiled_program_config }
      dap.configurations.c = { compiled_program_config }
      dap.configurations.cpp = { compiled_program_config }

      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP continue/start" })
      vim.keymap.set("n", "<F6>", dap.step_over, { desc = "DAP step over" })
      vim.keymap.set("n", "<F7>", dap.step_into, { desc = "DAP step into" })
      vim.keymap.set("n", "<F8>", dap.step_out, { desc = "DAP step out" })
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
      vim.keymap.set("n", "<F10>", dap.terminate, { desc = "DAP terminate" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP conditional breakpoint" })
      vim.keymap.set("n", "<leader>dC", function()
        dap.clear_breakpoints()
        vim.notify("DAP breakpoints cleared", vim.log.levels.INFO)
      end, { desc = "DAP clear all breakpoints" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP continue" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP run last" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI toggle" })
      vim.keymap.set("n", "<leader>do", open_dap_ui, { desc = "DAP UI open" })
      vim.keymap.set("n", "<leader>dx", dapui.close, { desc = "DAP UI close" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "DAP terminate" })

      vim.api.nvim_create_user_command("DapUiOpen", open_dap_ui, { desc = "Open DAP UI" })
      vim.api.nvim_create_user_command("DapUiClose", dapui.close, { desc = "Close DAP UI" })
    end,
  },
}
