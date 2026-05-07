-- return {
--     "nvim-treesitter/nvim-treesitter",
--     build = function()
--         -- Chỉ cài đặt parsers khi chạy build (Lazy sync/update)
--         local parsers = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }
--         require("nvim-treesitter").install(parsers)
--     end,
--     lazy = false,
--     config = function()
--         require("nvim-treesitter").setup({
--             install_dir = vim.fn.stdpath("data") .. "/site",
--         })

--         -- Bật treesitter highlight cho tất cả filetypes có parser
--         vim.api.nvim_create_autocmd("FileType", {
--             callback = function()
--                 pcall(vim.treesitter.start)
--             end,
--         })
--     end,
-- }
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local okTreesitter, treesitter = pcall(require, "nvim-treesitter")
    if not okTreesitter then
      vim.schedule(function()
        vim.notify(
          string.format("Failed to load nvim-treesitter: %s", tostring(treesitter)),
          vim.log.levels.ERROR,
          { title = "Treesitter" }
        )
      end)
      return
    end

    local treesitterHelper = require("config.treesitter")
    local parsers = {
      "lua",
      "vim",
      "vimdoc",
      "query",
      "python",
      "javascript",
      "typescript",
      "c",
      "cpp",
      "rust",
      "go",
      "bash",
      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",
      "html",
      "css",
    }

    local okSetup, setupError = pcall(treesitter.setup, {
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
    if not okSetup then
      vim.schedule(function()
        vim.notify(
          string.format("Treesitter setup failed: %s", tostring(setupError)),
          vim.log.levels.WARN,
          { title = "Treesitter" }
        )
      end)
    end

    if type(treesitter.install) == "function" then
      local okInstall, installError = pcall(treesitter.install, parsers)
      if not okInstall then
        vim.schedule(function()
          vim.notify(
            string.format("Treesitter bulk install could not start: %s", tostring(installError)),
            vim.log.levels.WARN,
            { title = "Treesitter" }
          )
        end)
      end
    end

    treesitterHelper.ensureParsers(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local maxFilesize = 100 * 1024
        local okStat, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))

        if okStat and stats ~= nil and stats.size > maxFilesize then
          return
        end

        treesitterHelper.startBuffer(args.buf)
      end,
    })
  end,
}
