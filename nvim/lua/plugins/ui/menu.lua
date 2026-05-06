-- Menu plugin for Neovim (supports nested menus)
-- https://github.com/nvzone/menu

-- ─────────────────────────────────────────────
-- LSP Submenu (matches image 2 right panel)
-- ─────────────────────────────────────────────
local lsp_menu = {
  {
    name = "Goto Definition",
    cmd = vim.lsp.buf.definition,
    rtxt = "gd",
  },
  {
    name = "Goto Declaration",
    cmd = vim.lsp.buf.declaration,
    rtxt = "gD",
  },
  {
    name = "Goto Implementation",
    cmd = vim.lsp.buf.implementation,
    rtxt = "gi",
  },
  { name = "separator" },
  {
    name = "Show Signature Help",
    cmd = vim.lsp.buf.signature_help,
    rtxt = "<leader>sh",
  },
  {
    name = "Add Workspace Folder",
    cmd = vim.lsp.buf.add_workspace_folder,
    rtxt = "<leader>wa",
  },
  {
    name = "Remove Workspace Folder",
    cmd = vim.lsp.buf.remove_workspace_folder,
    rtxt = "<leader>wr",
  },
  {
    name = "Show References",
    cmd = function()
      require("telescope.builtin").lsp_references()
    end,
    rtxt = "gr",
  },
  { name = "separator" },
  {
    name = "Format Buffer",
    cmd = function()
      local ok, conform = pcall(require, "conform")
      if ok then
        conform.format({ lsp_fallback = true })
      else
        vim.lsp.buf.format()
      end
    end,
    rtxt = "<leader>fm",
  },
  {
    name = "Code Actions",
    cmd = vim.lsp.buf.code_action,
    rtxt = "<leader>ca",
  },
}

local function toggle_visual_line_comment()
  local api = require("Comment.api")
  api.locked("toggle.linewise")(vim.fn.visualmode())
end

local function toggle_visual_block_comment()
  local api = require("Comment.api")
  api.locked("toggle.blockwise")(vim.fn.visualmode())
end

-- ─────────────────────────────────────────────
-- Main Menu (matches image 2 left panel)
-- ─────────────────────────────────────────────
local main_menu = {
  {
    name = "Format Buffer",
    cmd = function()
      local ok, conform = pcall(require, "conform")
      if ok then
        conform.format({ lsp_fallback = true })
      else
        vim.lsp.buf.format()
      end
    end,
    rtxt = "<leader>fm",
  },
  {
    name = "Code Actions",
    cmd = vim.lsp.buf.code_action,
    rtxt = "<leader>ca",
  },
  {
    name = "Comment Line",
    cmd = require("Comment.api").toggle.linewise.current,
    rtxt = "<leader>cc",
  },
  {
    name = "Comment Block",
    cmd = require("Comment.api").toggle.blockwise.current,
    rtxt = "<leader>cb",
  },
  { name = "separator" },
  {
    name = "Lsp Actions",
    items = lsp_menu,
  },
  { name = "separator" },
  {
    name = "Split Window Horizontally",
    cmd = function()
      vim.cmd("split")
    end,
    rtxt = "sp",
  },
  {
    name = "Split Window Vertically",
    cmd = function()
      vim.cmd("vsplit")
    end,
    rtxt = "vs",
  },
  {
    name = "Edit Config",
    cmd = function()
      vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua")
    end,
    rtxt = "ed",
  },
  {
    name = "Copy Content",
    cmd = function()
      vim.cmd("%y+")
    end,
    rtxt = "<C-c>",
  },
  {
    name = "Delete Content",
    cmd = function()
      vim.cmd("%d")
    end,
    rtxt = "dc",
  },
  { name = "separator" },
  {
    name = "Open in Terminal",
    cmd = function()
      vim.cmd("terminal")
    end,
  },
}

-- ─────────────────────────────────────────────
-- File Tree Menu (matches image 1)
-- ─────────────────────────────────────────────
local filetree_menu = {
  {
    name = "New File",
    cmd = function()
      local path = vim.fn.input("New file: ", vim.fn.expand("%:p:h") .. "/")
      if path ~= "" then vim.cmd("e " .. path) end
    end,
    rtxt = "a",
  },
  {
    name = "New Folder",
    cmd = function()
      local path = vim.fn.input("New folder: ", vim.fn.expand("%:p:h") .. "/")
      if path ~= "" then vim.fn.mkdir(path, "p") end
    end,
    rtxt = "a",
  },
  { name = "separator" },
  {
    name = "Open in Window",
    cmd = function() vim.cmd("e " .. vim.fn.expand("%")) end,
    rtxt = "o",
  },
  {
    name = "Open in Vertical Split",
    cmd = function() vim.cmd("vsp " .. vim.fn.expand("%")) end,
    rtxt = "v",
  },
  {
    name = "Open in Horizontal Split",
    cmd = function() vim.cmd("sp " .. vim.fn.expand("%")) end,
    rtxt = "s",
  },
  {
    name = "Open in New Tab",
    cmd = function() vim.cmd("tabnew " .. vim.fn.expand("%")) end,
    rtxt = "O",
  },
  { name = "separator" },
  {
    name = "Cut",
    cmd = function() vim.cmd("normal! dd") end,
    rtxt = "x",
  },
  {
    name = "Paste",
    cmd = function() vim.cmd("normal! p") end,
    rtxt = "p",
  },
  {
    name = "Copy",
    cmd = function() vim.cmd("normal! yy") end,
    rtxt = "c",
  },
  {
    name = "Copy Absolute Path",
    cmd = function()
      vim.fn.setreg("+", vim.fn.expand("%:p"))
      vim.notify("Copied: " .. vim.fn.expand("%:p"))
    end,
    rtxt = "gy",
  },
  {
    name = "Copy Relative Path",
    cmd = function()
      vim.fn.setreg("+", vim.fn.expand("%"))
      vim.notify("Copied: " .. vim.fn.expand("%"))
    end,
    rtxt = "Y",
  },
  { name = "separator" },
  {
    name = "Open in Terminal",
    cmd = function()
      vim.cmd("lcd " .. vim.fn.expand("%:p:h"))
      vim.cmd("terminal")
    end,
  },
  { name = "separator" },
  {
    name = "Rename",
    cmd = function()
      local old = vim.fn.expand("%:p")
      local new = vim.fn.input("Rename to: ", old)
      if new ~= "" and new ~= old then
        vim.fn.rename(old, new)
        vim.cmd("e " .. new)
      end
    end,
    rtxt = "r",
  },
  {
    name = "Trash",
    cmd = function()
      local file = vim.fn.expand("%:p")
      vim.fn.system("trash " .. vim.fn.shellescape(file))
      vim.cmd("bd")
    end,
    rtxt = "D",
  },
  {
    name = "Delete",
    cmd = function()
      local file = vim.fn.expand("%:p")
      if vim.fn.confirm("Delete " .. file .. "?", "&Yes\n&No") == 1 then
        vim.fn.delete(file)
        vim.cmd("bd")
      end
    end,
    rtxt = "d",
  },
}

-- ─────────────────────────────────────────────
-- Plugin spec
-- ─────────────────────────────────────────────
local visual_menu = {
  {
    name = "Comment Selection",
    cmd = toggle_visual_line_comment,
    rtxt = "<leader>cc",
  },
  {
    name = "Block Comment Selection",
    cmd = toggle_visual_block_comment,
    rtxt = "<leader>cb",
  },
  { name = "separator" },
  {
    name = "Code Actions",
    cmd = vim.lsp.buf.code_action,
    rtxt = "<leader>ca",
  },
  {
    name = "Copy Selection",
    cmd = function()
      vim.cmd('normal! "*y')
    end,
    rtxt = "y",
  },
}

local config = {
  mouse = true,
  border = true,
}

return {
  {
    "nvzone/volt",
    lazy = true,
  },
  {
    "nvzone/menu",
    dependencies = { "nvzone/volt" },
    keys = {
      -- Editor context menu
      {
        "<C-Space>",
        function()
          local mode = vim.fn.mode()
          local menu_items = mode:match("^[vV\22]") and visual_menu or main_menu
          require("menu").open(menu_items, config)
        end,
        mode = { "n", "v", "x" },
        desc = "Open main menu",
      },
      -- File tree menu
      {
        "<leader>fm",
        function()
          require("menu").open(filetree_menu, config)
        end,
        desc = "Open file menu",
      },
      -- Right-click: smart menu depending on window type
      {
        "<RightMouse>",
        function()
          require("menu.utils").delete_old_menus()

          local mouse = vim.fn.getmousepos()
          if mouse.winid == 0 then return end
          vim.api.nvim_set_current_win(mouse.winid)

          local buf = vim.api.nvim_win_get_buf(mouse.winid)
          local ft = vim.bo[buf].filetype
          local mode = vim.fn.mode()

          -- Use file tree menu for file explorers
          local tree_fts = { "neo-tree", "NvimTree", "oil" }
          local is_tree = vim.tbl_contains(tree_fts, ft)

          local menu_items
          if is_tree then
            menu_items = filetree_menu
          elseif mode:match("^[vV\22]") then
            menu_items = visual_menu
          else
            menu_items = main_menu
          end

          require("menu").open(menu_items, config)
        end,
        mode = { "n", "v", "x" },
        desc = "Open context menu",
      },
    },
  },
}
