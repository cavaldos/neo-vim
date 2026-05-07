-- Quicklist Plugin
-- Two-panel floating window: left = plugin list, right = keybindings

local state = {
  left_buf     = nil,
  right_buf    = nil,
  left_win     = nil,
  right_win    = nil,
  previous_win = nil,
  visible      = false,
  ns           = vim.api.nvim_create_namespace("quicklist"),
  selected     = 1,
  kb_selected  = 1,
  focus        = "left", -- "left" | "right"
}

local M = {}

local function has_user_command(name)
  return vim.fn.exists(':' .. name) == 2
end

local function simplify_error(err)
  local message = tostring(err)
  message = message:gsub("\nstack traceback:.*", "")
  message = message:gsub("vim/_core/editor%.lua:%d+: ", "")
  message = message:gsub("nvim_exec2%(%)[,]? line %d+: ", "")
  message = message:gsub("cache_loader: module '[^']+' not found", "module not found")
  message = message:gsub("cache_loader_lib: module '[^']+' not found", "module not found")
  message = message:gsub("module '[^']+' not found.*", "required plugin/module not found")
  message = message:gsub("%s+", " ")
  return vim.trim(message)
end

local function echo_message(message, highlight)
  vim.schedule(function()
    vim.api.nvim_echo({ { string.format("QuickList: %s", message), highlight } }, false, {})
  end)
end

local function notify_error(message)
  echo_message(message, "ErrorMsg")
end

local function notify_warn(message)
  echo_message(message, "WarningMsg")
end

local function safe_cmd(command, label)
  return function()
    local ok, err = pcall(vim.cmd, command)
    if not ok then
      notify_error(string.format("%s failed: %s", label or command, simplify_error(err)))
    end
  end
end

local function run_cmd_if_exists(command_name, fallback)
  return function()
    if has_user_command(command_name) then
      safe_cmd(command_name, command_name)()
      return
    end

    if fallback then
      local ok, err = pcall(fallback)
      if not ok then
        notify_error(string.format("%s failed: %s", command_name, simplify_error(err)))
      end
      return
    end

    notify_warn(string.format("Command not found: %s", command_name))
  end
end

local function safe_require_call(module_name, fn_name, args)
  return function()
    local ok, mod = pcall(require, module_name)
    if not ok then
      notify_warn(string.format("%s unavailable", module_name))
      return
    end

    local fn = mod[fn_name]
    if type(fn) ~= "function" then
      notify_warn(string.format("%s.%s unavailable", module_name, fn_name))
      return
    end

    fn(unpack(args or {}))
  end
end

local function run_action(action, label)
  local ok, err = xpcall(action, debug.traceback)
  if not ok then
    local message = simplify_error(err)
    notify_error(string.format("%s failed: %s", label or "Action", message))
  end
end

-- ─────────────────────────────────────────────
--  Plugin definitions with keybindings
-- ─────────────────────────────────────────────
local plugins = {
  {
    text = "Telescope",
    icon = " ",
    keybindings = {
      { key = "<leader>ff", desc = "Find Files",           action = safe_cmd("Telescope find_files", "Telescope find_files") },
      { key = "<leader>fg", desc = "Live Grep",            action = safe_cmd("Telescope live_grep", "Telescope live_grep") },
      { key = "<leader>fb", desc = "Buffers",              action = safe_cmd("Telescope buffers", "Telescope buffers") },
      { key = "<leader>fh", desc = "Help Tags",            action = safe_cmd("Telescope help_tags", "Telescope help_tags") },
      { key = "<leader>fr", desc = "Recent Files",         action = safe_cmd("Telescope oldfiles", "Telescope oldfiles") },
      { key = "<leader>fc", desc = "Commands",             action = safe_cmd("Telescope commands", "Telescope commands") },
      { key = "<leader>fk", desc = "Keymaps",              action = safe_cmd("Telescope keymaps", "Telescope keymaps") },
      { key = "<leader>fd", desc = "Diagnostics",          action = safe_cmd("Telescope diagnostics", "Telescope diagnostics") },
      { key = "<leader>fs", desc = "Doc Symbols",          action = safe_cmd("Telescope lsp_document_symbols", "Telescope lsp_document_symbols") },
      { key = "<leader>fw", desc = "Workspace Symbols",    action = safe_cmd("Telescope lsp_workspace_symbols", "Telescope lsp_workspace_symbols") },
      { key = "<leader>ft", desc = "Treesitter Nodes",     action = safe_cmd("Telescope treesitter", "Telescope treesitter") },
      { key = "<leader>fm", desc = "Marks",                action = safe_cmd("Telescope marks", "Telescope marks") },
      { key = "<leader>fj", desc = "Jumplist",             action = safe_cmd("Telescope jumplist", "Telescope jumplist") },
    },
  },
  {
    text = "FZF / fzf.vim",
    icon = " ",
    keybindings = {
      { key = "<leader>zf", desc = "Files",                action = run_cmd_if_exists("Files") },
      { key = "<leader>zg", desc = "Live Grep",            action = run_cmd_if_exists("Rg") },
      { key = "<leader>zb", desc = "Buffers",              action = run_cmd_if_exists("Buffers") },
      { key = "<leader>zh", desc = "Help Tags",            action = run_cmd_if_exists("Helptags") },
      { key = "<leader>zr", desc = "Recent Files",         action = run_cmd_if_exists("History") },
      { key = "<leader>zc", desc = "Commands",             action = run_cmd_if_exists("Commands") },
      { key = "<leader>zk", desc = "Keymaps",              action = run_cmd_if_exists("Maps") },
      { key = "<leader>zd", desc = "Diagnostics",          action = function() vim.diagnostic.setqflist(); safe_cmd("copen", "Open quickfix")() end },
      { key = "<leader>zs", desc = "Doc Symbols",          action = function() vim.lsp.buf.document_symbol() end },
      { key = "<leader>zm", desc = "Marks",                action = run_cmd_if_exists("Marks") },
      { key = "<leader>zj", desc = "Jumps",                action = run_cmd_if_exists("Jumps") },
      { key = "<leader>zt", desc = "Tags",                 action = run_cmd_if_exists("BTags", safe_cmd("tags", "Show tags")) },
    },
  },
  {
    text = "Git (Fugitive)",
    icon = " ",
    keybindings = {
      { key = "<leader>gs", desc = "Git Status",           action = safe_cmd("Git", "Git status") },
      { key = "<leader>ga", desc = "Git Add (current)",    action = safe_cmd("Git add %", "Git add current file") },
      { key = "<leader>gc", desc = "Git Commit",           action = safe_cmd("Git commit", "Git commit") },
      { key = "<leader>gp", desc = "Git Push",             action = safe_cmd("Git push", "Git push") },
      { key = "<leader>gl", desc = "Git Log",              action = safe_cmd("Git log --oneline", "Git log") },
      { key = "<leader>gd", desc = "Git Diff",             action = safe_cmd("Gdiffsplit", "Git diff split") },
      { key = "<leader>gb", desc = "Git Blame",            action = safe_cmd("Git blame", "Git blame") },
      { key = "<leader>gm", desc = "Git Mergetool",        action = safe_cmd("Git mergetool", "Git mergetool") },
    },
  },
  {
    text = "LSP",
    icon = "󰒍 ",
    keybindings = {
      { key = "gd",          desc = "Go to Definition",    action = function() vim.lsp.buf.definition() end },
      { key = "gD",          desc = "Go to Declaration",   action = function() vim.lsp.buf.declaration() end },
      { key = "gr",          desc = "References",          action = function() vim.lsp.buf.references() end },
      { key = "gi",          desc = "Implementation",      action = function() vim.lsp.buf.implementation() end },
      { key = "K",           desc = "Hover Docs",          action = function() vim.lsp.buf.hover() end },
      { key = "<leader>rn",  desc = "Rename Symbol",       action = function() vim.lsp.buf.rename() end },
      { key = "<leader>ca",  desc = "Code Action",         action = function() vim.lsp.buf.code_action() end },
      { key = "<leader>cf",  desc = "Format File",         action = function() vim.lsp.buf.format() end },
      { key = "[d",          desc = "Prev Diagnostic",     action = function() vim.diagnostic.goto_prev() end },
      { key = "]d",          desc = "Next Diagnostic",     action = function() vim.diagnostic.goto_next() end },
      { key = "<leader>e",   desc = "Show Diagnostics",    action = function() vim.diagnostic.open_float() end },
    },
  },
  {
    text = "Neo-tree",
    icon = "󰙅 ",
    keybindings = {
      { key = "<leader>e",   desc = "Toggle Explorer",     action = safe_cmd("Neotree toggle", "Neotree toggle") },
      { key = "<leader>ef",  desc = "Focus Explorer",      action = safe_cmd("Neotree focus", "Neotree focus") },
      { key = "<leader>eg",  desc = "Git Status Tree",     action = safe_cmd("Neotree git_status", "Neotree git status") },
      { key = "<leader>eb",  desc = "Buffers Tree",        action = safe_cmd("Neotree buffers", "Neotree buffers") },
    },
  },
  {
    text = "Buffers",
    icon = "󰓩 ",
    keybindings = {
      { key = "<leader>bn",  desc = "Next Buffer",         action = safe_cmd("bnext", "Next buffer") },
      { key = "<leader>bp",  desc = "Prev Buffer",         action = safe_cmd("bprev", "Previous buffer") },
      { key = "<leader>bd",  desc = "Delete Buffer",       action = safe_cmd("bdelete", "Delete buffer") },
      { key = "<leader>bD",  desc = "Force Delete",        action = safe_cmd("bdelete!", "Force delete buffer") },
      { key = "<leader>bl",  desc = "List Buffers",        action = safe_cmd("Telescope buffers", "Telescope buffers") },
    },
  },
  {
    text = "Harpoon",
    icon = "󱠇 ",
    keybindings = {
      { key = "<leader>ha",  desc = "Add File",            action = safe_require_call("harpoon.mark", "add_file") },
      { key = "<leader>hm",  desc = "Toggle Menu",         action = safe_require_call("harpoon.ui", "toggle_quick_menu") },
      { key = "<leader>h1",  desc = "File 1",              action = safe_require_call("harpoon.ui", "nav_file", { 1 }) },
      { key = "<leader>h2",  desc = "File 2",              action = safe_require_call("harpoon.ui", "nav_file", { 2 }) },
      { key = "<leader>h3",  desc = "File 3",              action = safe_require_call("harpoon.ui", "nav_file", { 3 }) },
      { key = "<leader>h4",  desc = "File 4",              action = safe_require_call("harpoon.ui", "nav_file", { 4 }) },
      { key = "<leader>hn",  desc = "Next Mark",           action = safe_require_call("harpoon.ui", "nav_next") },
      { key = "<leader>hp",  desc = "Prev Mark",           action = safe_require_call("harpoon.ui", "nav_prev") },
    },
  },
  {
    text = "Trouble",
    icon = "󱖫 ",
    keybindings = {
      { key = "<leader>xx",  desc = "Toggle Trouble",      action = safe_cmd("TroubleToggle", "Trouble toggle") },
      { key = "<leader>xw",  desc = "Workspace Diag.",     action = safe_cmd("TroubleToggle workspace_diagnostics", "Trouble workspace diagnostics") },
      { key = "<leader>xd",  desc = "Document Diag.",      action = safe_cmd("TroubleToggle document_diagnostics", "Trouble document diagnostics") },
      { key = "<leader>xq",  desc = "QuickFix",            action = safe_cmd("TroubleToggle quickfix", "Trouble quickfix") },
      { key = "<leader>xl",  desc = "Location List",       action = safe_cmd("TroubleToggle loclist", "Trouble location list") },
      { key = "gR",          desc = "LSP References",      action = safe_cmd("TroubleToggle lsp_references", "Trouble LSP references") },
    },
  },
  {
    text = "DAP (Debugger)",
    icon = " ",
    keybindings = {
      { key = "<F5>",        desc = "Continue / Start",    action = safe_require_call("dap", "continue") },
      { key = "<F10>",       desc = "Step Over",           action = safe_require_call("dap", "step_over") },
      { key = "<F11>",       desc = "Step Into",           action = safe_require_call("dap", "step_into") },
      { key = "<F12>",       desc = "Step Out",            action = safe_require_call("dap", "step_out") },
      { key = "<leader>db",  desc = "Toggle Breakpoint",   action = safe_require_call("dap", "toggle_breakpoint") },
      { key = "<leader>dr",  desc = "Open REPL",           action = function()
        local ok, dap = pcall(require, "dap")
        if not ok then
          notify_warn("dap unavailable")
          return
        end
        if dap.repl and type(dap.repl.open) == "function" then
          dap.repl.open()
        else
          notify_warn("dap.repl.open unavailable")
        end
      end },
      { key = "<leader>du",  desc = "Toggle DAP UI",       action = safe_require_call("dapui", "toggle") },
    },
  },
  {
    text = "QuickFix / Location",
    icon = " ",
    keybindings = {
      { key = "<leader>qo",  desc = "Open QuickFix",       action = safe_cmd("copen", "Open quickfix") },
      { key = "<leader>qc",  desc = "Close QuickFix",      action = safe_cmd("cclose", "Close quickfix") },
      { key = "]q",          desc = "Next QuickFix",       action = safe_cmd("cnext", "Next quickfix") },
      { key = "[q",          desc = "Prev QuickFix",       action = safe_cmd("cprev", "Previous quickfix") },
      { key = "<leader>lo",  desc = "Open Location",       action = safe_cmd("lopen", "Open location list") },
      { key = "]l",          desc = "Next Location",       action = safe_cmd("lnext", "Next location") },
      { key = "[l",          desc = "Prev Location",       action = safe_cmd("lprev", "Previous location") },
    },
  },
  {
    text = "Marks & Jumps",
    icon = " ",
    keybindings = {
      { key = "m{a-z}",      desc = "Set Local Mark",      action = safe_cmd("marks", "Show marks") },
      { key = "`{mark}",     desc = "Jump to Mark",        action = safe_cmd("marks", "Show marks") },
      { key = "<leader>mk",  desc = "View All Marks",      action = safe_cmd("Telescope marks", "Telescope marks") },
      { key = "<C-o>",       desc = "Jump Back",           action = safe_cmd("normal! \15", "Jump back") },
      { key = "<C-i>",       desc = "Jump Forward",        action = safe_cmd("normal! \9", "Jump forward") },
      { key = "<leader>jp",  desc = "View Jumplist",       action = safe_cmd("Telescope jumplist", "Telescope jumplist") },
    },
  },
  {
    text = "Registers",
    icon = "󱉒 ",
    keybindings = {
      { key = "<leader>rg",  desc = "View Registers",      action = safe_cmd("Telescope registers", "Telescope registers") },
      { key = '"<reg>y',     desc = "Yank to Register",    action = safe_cmd("registers", "Show registers") },
      { key = '"<reg>p',     desc = "Paste from Register", action = safe_cmd("registers", "Show registers") },
      { key = '"+y',         desc = "Yank to Clipboard",   action = safe_cmd("registers", "Show registers") },
      { key = '"+p',         desc = "Paste Clipboard",     action = safe_cmd("registers", "Show registers") },
      { key = "<leader>ch",  desc = "Changes History",     action = safe_cmd("changes", "Show changes") },
    },
  },
}

-- ─────────────────────────────────────────────
--  Layout constants
-- ─────────────────────────────────────────────
local LEFT_W  = 26
local RIGHT_W = 48
local HEIGHT  = 22

-- Pad string to exactly `width` display-cells
local function pad(s, width)
  local w = vim.api.nvim_strwidth(s)
  if w < width then
    return s .. string.rep(" ", width - w)
  end
  -- truncate if over (shouldn't happen with good constants)
  return s:sub(1, width)
end

-- Paint coloured segments onto a buffer row.
-- `col` is tracked in BYTES (what nvim_buf_set_extmark expects).
-- The line must already be written (padded) so every col is valid.
local function paint(buf, ns, row, segments)
  local byte_col = 0
  for _, seg in ipairs(segments) do
    local text, group = seg[1], seg[2]
    if text ~= "" then
      vim.api.nvim_buf_set_extmark(buf, ns, row, byte_col, {
        virt_text     = { { text, group } },
        virt_text_pos = "overlay",
        hl_mode       = "combine",
      })
    end
    byte_col = byte_col + #text  -- # gives byte length in Lua
  end
end

-- ─────────────────────────────────────────────
--  Left panel renderer
-- ─────────────────────────────────────────────
local function render_left(buf)
  vim.api.nvim_buf_clear_namespace(buf, state.ns, 0, -1)

  -- Build exactly HEIGHT lines, each padded to LEFT_W bytes/display-cells
  -- (all content here is ASCII so bytes == display width)
  local lines = {}

  lines[1] = pad("", LEFT_W)                        -- row 0: spacer
  lines[2] = pad(" Quick List", LEFT_W)             -- row 1: title
  lines[3] = pad(string.rep("-", LEFT_W), LEFT_W)   -- row 2: separator

  for i, p in ipairs(plugins) do                    -- rows 3..3+#plugins-1
    local sel  = state.selected == i
    -- strip icon to avoid byte/display mismatch in pad(); we'll overlay it
    local line = string.format("   %s  %s", sel and ">" or " ", p.text)
    lines[3 + i] = pad(line, LEFT_W)
  end

  local filled = 3 + #plugins
  for r = filled + 1, HEIGHT - 1 do                 -- blank rows
    lines[r] = pad("", LEFT_W)
  end
  lines[HEIGHT - 1] = pad(string.rep("-", LEFT_W), LEFT_W)  -- row HEIGHT-2: sep
  lines[HEIGHT]     = pad("  j/k  Tab  Enter  q",  LEFT_W)  -- row HEIGHT-1: hint

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- ── Highlights (all rows 0-indexed) ──
  local ns      = state.ns
  local focused = state.focus == "left"

  paint(buf, ns, 1, {
    { " ",          "linenr" },
    { "Quick List", focused and "exblue" or "commentfg" },
  })
  paint(buf, ns, 2, { { string.rep("-", LEFT_W), "linenr" } })

  for i, p in ipairs(plugins) do
    local row = 2 + i   -- 0-indexed
    local sel = state.selected == i
    -- Use ASCII arrow to avoid multi-byte issues in col tracking
    paint(buf, ns, row, {
      { " ",     "linenr" },
      { sel and ">" or " ",  sel and "exgreen" or "linenr" },
      { " ",     "linenr" },
      { (p.icon or "  "), sel and "exgreen" or "commentfg" },
      { " ",     "linenr" },
      { p.text,  sel and "exblue" or "normal" },
    })
  end

  paint(buf, ns, HEIGHT - 2, { { string.rep("-", LEFT_W), "linenr" } })
  paint(buf, ns, HEIGHT - 1, {
    { "  ",    "linenr" },
    { "j/k",   "exgreen" },
    { "  ",    "linenr" },
    { "Tab",   "exgreen" },
    { "  ",    "linenr" },
    { "Enter", "exgreen" },
    { "  ",    "linenr" },
    { "q",     "exgreen" },
  })
end

-- ─────────────────────────────────────────────
--  Right panel renderer
-- ─────────────────────────────────────────────
local function render_right(buf)
  vim.api.nvim_buf_clear_namespace(buf, state.ns, 0, -1)

  local p = plugins[state.selected]
  if not p then return end

  local total = #p.keybindings
  state.kb_selected = math.max(1, math.min(state.kb_selected, total))

  local max_show = HEIGHT - 5
  local start    = math.max(1, math.min(
    state.kb_selected - math.floor(max_show / 2),
    total - max_show + 1
  ))
  start = math.max(1, start)

  local lines = {}

  lines[1] = pad("", RIGHT_W)
  -- strip icon from pad() call to avoid multi-byte width issues
  local title_plain = string.format("  %s  Keybindings  (%d)", p.text, total)
  lines[2] = pad(title_plain, RIGHT_W)
  lines[3] = pad(string.rep("-", RIGHT_W), RIGHT_W)

  local shown = 0
  for i = start, math.min(start + max_show - 1, total) do
    shown = shown + 1
    local kb  = p.keybindings[i]
    local sel = state.focus == "right" and state.kb_selected == i
    local ind = sel and "*" or " "
    -- key = 16 chars, desc follows
    local line = string.format(" %s %-16s  %s", ind, kb.key, kb.desc)
    lines[3 + shown] = pad(line, RIGHT_W)
  end

  local filled = 3 + shown
  for r = filled + 1, HEIGHT - 1 do
    lines[r] = pad("", RIGHT_W)
  end
  lines[HEIGHT - 1] = pad(string.rep("-", RIGHT_W), RIGHT_W)
  lines[HEIGHT]     = pad(
    string.format("  %d/%d   Enter:run   Tab:back", total, total),
    RIGHT_W
  )

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- ── Highlights ──
  local ns      = state.ns
  local focused = state.focus == "right"

  -- title row: we paint icon separately then the rest
  local icon_bytes = #(p.icon or "")
  paint(buf, ns, 1, {
    { " ",     "linenr" },
    { " ",     "linenr" },   -- 2 spaces before icon placeholder
    { p.icon or "", focused and "exgreen" or "commentfg" },
    -- rest of title after icon
    { string.format(" %s  Keybindings  (%d)", p.text, total),
      focused and "exblue" or "commentfg" },
  })
  _ = icon_bytes  -- suppress unused warning

  paint(buf, ns, 2, { { string.rep("-", RIGHT_W), "linenr" } })

  for idx = start, math.min(start + max_show - 1, total) do
    local row = 2 + (idx - start + 1)   -- 0-indexed
    local kb  = p.keybindings[idx]
    local sel = focused and state.kb_selected == idx

    paint(buf, ns, row, {
      { " ",                             "linenr" },
      { sel and "*" or " ",              sel and "exgreen" or "commentfg" },
      { " ",                             "linenr" },
      { string.format("%-16s", kb.key),  sel and "exorange" or "exblue" },
      { "  ",                            "linenr" },
      { kb.desc,                         sel and "normal" or "commentfg" },
    })
  end

  paint(buf, ns, HEIGHT - 2, { { string.rep("-", RIGHT_W), "linenr" } })
  paint(buf, ns, HEIGHT - 1, {
    { "  ",          "linenr" },
    { string.format("%d/%d", total, total), "commentfg" },
    { "   ",         "linenr" },
    { "Enter",       "exgreen" },
    { ":run   ",     "commentfg" },
    { "Tab",         "exgreen" },
    { ":back",       "commentfg" },
  })
end

-- ─────────────────────────────────────────────
--  Render both panels
-- ─────────────────────────────────────────────
local function render_all()
  if state.left_buf and vim.api.nvim_buf_is_valid(state.left_buf) then
    vim.bo[state.left_buf].modifiable = true
    render_left(state.left_buf)
    vim.bo[state.left_buf].modifiable = false
  end
  if state.right_buf and vim.api.nvim_buf_is_valid(state.right_buf) then
    vim.bo[state.right_buf].modifiable = true
    render_right(state.right_buf)
    vim.bo[state.right_buf].modifiable = false
  end
end

local function restore_previous_win()
  local current_win = vim.api.nvim_get_current_win()
  local current_config = vim.api.nvim_win_get_config(current_win)

  if current_config.relative == "" then
    return true
  end

  local win = state.previous_win
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_set_current_win(win)
    return true
  end

  for _, win_info in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win_info)
    if config.relative == "" then
      vim.api.nvim_set_current_win(win_info)
      return true
    end
  end

  return false
end

local function render_right_safe()
  if state.right_buf and vim.api.nvim_buf_is_valid(state.right_buf) then
    vim.bo[state.right_buf].modifiable = true
    render_right(state.right_buf)
    vim.bo[state.right_buf].modifiable = false
  end
end

-- ─────────────────────────────────────────────
--  Keymaps
-- ─────────────────────────────────────────────
local function set_keymaps()
  local function map(buf, lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, nowait = true })
  end

  local function switch_to_right()
    state.focus = "right"
    render_all()
    if state.right_win and vim.api.nvim_win_is_valid(state.right_win) then
      vim.api.nvim_set_current_win(state.right_win)
    end
  end

  local function switch_to_left()
    state.focus = "left"
    render_all()
    if state.left_win and vim.api.nvim_win_is_valid(state.left_win) then
      vim.api.nvim_set_current_win(state.left_win)
    end
  end

  -- Left panel
  local lb = state.left_buf
  map(lb, "q",      M.close)
  map(lb, "<Esc>",  M.close)
  map(lb, "<Tab>",  switch_to_right)
  map(lb, "<CR>",   switch_to_right)
  map(lb, "l",      switch_to_right)

  map(lb, "j", function()
    if state.selected < #plugins then
      state.selected    = state.selected + 1
      state.kb_selected = 1
      render_all()
    end
  end)
  map(lb, "<Down>", function()
    if state.selected < #plugins then
      state.selected    = state.selected + 1
      state.kb_selected = 1
      render_all()
    end
  end)
  map(lb, "k", function()
    if state.selected > 1 then
      state.selected    = state.selected - 1
      state.kb_selected = 1
      render_all()
    end
  end)
  map(lb, "<Up>", function()
    if state.selected > 1 then
      state.selected    = state.selected - 1
      state.kb_selected = 1
      render_all()
    end
  end)
  map(lb, "gg", function() state.selected = 1; state.kb_selected = 1; render_all() end)
  map(lb, "G",  function() state.selected = #plugins; state.kb_selected = 1; render_all() end)

  -- Right panel
  local rb = state.right_buf
  map(rb, "q",       M.close)
  map(rb, "<Esc>",   M.close)
  map(rb, "<Tab>",   switch_to_left)
  map(rb, "<S-Tab>", switch_to_left)
  map(rb, "h",       switch_to_left)

  map(rb, "j", function()
    local p = plugins[state.selected]
    if p and state.kb_selected < #p.keybindings then
      state.kb_selected = state.kb_selected + 1
      render_right_safe()
    end
  end)
  map(rb, "<Down>", function()
    local p = plugins[state.selected]
    if p and state.kb_selected < #p.keybindings then
      state.kb_selected = state.kb_selected + 1
      render_right_safe()
    end
  end)
  map(rb, "k", function()
    if state.kb_selected > 1 then
      state.kb_selected = state.kb_selected - 1
      render_right_safe()
    end
  end)
  map(rb, "<Up>", function()
    if state.kb_selected > 1 then
      state.kb_selected = state.kb_selected - 1
      render_right_safe()
    end
  end)
  map(rb, "gg", function() state.kb_selected = 1; render_right_safe() end)
  map(rb, "G", function()
    local p = plugins[state.selected]
    if p then state.kb_selected = #p.keybindings; render_right_safe() end
  end)
  map(rb, "<CR>", function()
    local p = plugins[state.selected]
    if p then
      local kb = p.keybindings[state.kb_selected]
      if kb and kb.action then
        M.close()
        vim.schedule(function()
          restore_previous_win()
          run_action(kb.action, string.format("%s → %s", p.text, kb.desc))
        end)
      end
    end
  end)
end

-- ─────────────────────────────────────────────
--  Open / Close / Toggle
-- ─────────────────────────────────────────────
function M.open()
  if state.visible then return end

  state.previous_win = vim.api.nvim_get_current_win()

  local gap     = 2
  local total_w = LEFT_W + gap + RIGHT_W + 4  -- +4 for two rounded borders
  local row     = 1
  local col     = vim.o.columns - total_w - 3  -- top-right corner

  local lb = vim.api.nvim_create_buf(false, true)
  state.left_buf = lb
  local lw = vim.api.nvim_open_win(lb, true, {
    relative  = "editor",
    row       = row,
    col       = col,
    width     = LEFT_W,
    height    = HEIGHT,
    style     = "minimal",
    border    = "rounded",
    zindex    = 100,
    title     = " Plugins ",
    title_pos = "center",
  })
  state.left_win = lw

  local rb = vim.api.nvim_create_buf(false, true)
  state.right_buf = rb
  local rw = vim.api.nvim_open_win(rb, false, {
    relative  = "editor",
    row       = row,
    col       = col + LEFT_W + gap + 2,
    width     = RIGHT_W,
    height    = HEIGHT,
    style     = "minimal",
    border    = "rounded",
    zindex    = 100,
    title     = " Keybindings ",
    title_pos = "center",
  })
  state.right_win = rw

  for _, win in ipairs({ lw, rw }) do
    vim.wo[win].winhl          = "Normal:Normal,FloatBorder:Comment"
    vim.wo[win].foldcolumn     = "0"
    vim.wo[win].signcolumn     = "no"
    vim.wo[win].cursorline     = false
    vim.wo[win].number         = false
    vim.wo[win].relativenumber = false
  end

  for _, buf in ipairs({ lb, rb }) do
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].buflisted = false
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = false
  end

  state.focus   = "left"
  state.visible = true

  render_all()
  set_keymaps()
end

function M.close()
  restore_previous_win()

  for _, w in ipairs({ state.right_win, state.left_win }) do
    if w and vim.api.nvim_win_is_valid(w) then
      vim.api.nvim_win_close(w, true)
    end
  end

  state.visible      = false
  state.left_win     = nil
  state.right_win    = nil
  state.left_buf     = nil
  state.right_buf    = nil
  state.previous_win = nil
end

function M.toggle()
  if state.visible then M.close() else M.open() end
end

-- ─────────────────────────────────────────────
--  Plugin spec
-- ─────────────────────────────────────────────
return {
  {
    "nvzone/volt",
    lazy = false,
    keys = {
      {
        "<leader>ql",
        function() M.toggle() end,
        desc = "Toggle Quick List",
      },
    },
    init = function()
      vim.api.nvim_create_user_command("QuickList",       function() M.open()   end, { desc = "Open Quick List" })
      vim.api.nvim_create_user_command("QuickListToggle", function() M.toggle() end, { desc = "Toggle Quick List" })
      vim.api.nvim_create_user_command("QuickListClose",  function() M.close()  end, { desc = "Close Quick List" })
    end,
  },
}
