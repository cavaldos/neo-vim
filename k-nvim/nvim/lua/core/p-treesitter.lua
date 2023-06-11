require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "cpp","lua", "tsx", "rust", "json", "graphql", "regex", "vim" },

  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {}
  },
  autotag = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  }
}

require('template-string').setup({
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python' }, -- filetypes where the plugin is active
  jsx_brackets = true, -- must add brackets to jsx attributes
  remove_template_string = false, -- remove backticks when there are no template string
  restore_quotes = {
    -- quotes used when "remove_template_string" option is enabled
    normal = [[']],
    jsx = [["]],
  },
})

























-- require("nvim-treesitter.configs").setup({
--   -- A list of parser names, or "all"
--   ensure_installed = { "c", "lua", "rust" },

--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   sync_install = false,

--   -- Automatically install missing parsers when entering buffer
--   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--   auto_install = true,

--   -- List of parsers to ignore installing (for "all")
--   ignore_install = { "javascript" },

--   ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
--   -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

--   highlight = {
--       -- `false` will disable the whole extension
--       enable = true,

--       -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--       -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--       -- the name of the parser)
--       -- list of language that will be disabled
--       disable = { "c", "rust" },
--       -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
--       disable = function(lang, buf)
--           local max_filesize = 100 * 1024 -- 100 KB
--           local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--           if ok and stats and stats.size > max_filesize then
--               return true
--           end
--       end,

--       -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--       -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--       -- Using this option may slow down your editor, and you may see some duplicate highlights.
--       -- Instead of true it can also be a list of languages
--       additional_vim_regex_highlighting = false,
--   },
-- })

-- -------web divicon------
-- local status, icons = pcall(require, "nvim-web-devicons")
-- if not status then
--   return
-- end

-- icons.setup({
--   -- your personnal icons can go here (to override)
--   -- DevIcon will be appended to `name`
--   override = {},
--   -- globally enable default icons (default to false)
--   -- will get overriden by `get_icons` option
--   default = true,
-- })

