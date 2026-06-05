local M = {}

local uv = vim.uv or vim.loop

local function output_path(suffix)
  suffix = suffix or ""
  local root = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":r")
  return vim.fn.shellescape(root .. suffix)
end

local function java_class_name()
  return vim.fn.shellescape(vim.fn.fnamemodify(vim.fn.expand("%:p"), ":t:r"))
end

local runners = {
  javascript = function(file)
    return "node " .. file
  end,
  typescript = function(file)
    return "tsx " .. file
  end,
  python = function(file)
    return "python3 " .. file
  end,
  ruby = function(file)
    return "ruby " .. file
  end,
  php = function(file)
    return "php " .. file
  end,
  lua = function(file)
    return "lua " .. file
  end,
  sh = function(file)
    return "bash " .. file
  end,
  bash = function(file)
    return "bash " .. file
  end,
  zsh = function(file)
    return "zsh " .. file
  end,
  go = function(file)
    return "go run " .. file
  end,
  rust = function(file)
    return "rustc " .. file .. " -o " .. output_path() .. " && " .. output_path()
  end,
  java = function(file)
    return "javac " .. file .. " && java " .. java_class_name()
  end,
  c = function(file)
    return "clang -g " .. file .. " -o " .. output_path() .. " && " .. output_path()
  end,
  cpp = function(file)
    return "clang++ -g " .. file .. " -o " .. output_path() .. " && " .. output_path()
  end,
  cs = function(file)
    return "dotnet run " .. file
  end,
  kotlin = function(file)
    return "kotlinc " .. file .. " -include-runtime -d " .. output_path(".jar") .. " && java -jar " .. output_path(".jar")
  end,
  swift = function(file)
    return "swift " .. file
  end,
  dart = function(file)
    return "dart run " .. file
  end,
  scala = function(file)
    return "scala " .. file
  end,
  perl = function(file)
    return "perl " .. file
  end,
  r = function(file)
    return "Rscript " .. file
  end,
}

local extension_to_filetype = {
  js = "javascript",
  mjs = "javascript",
  cjs = "javascript",
  ts = "typescript",
  py = "python",
  rb = "ruby",
  php = "php",
  lua = "lua",
  sh = "sh",
  bash = "bash",
  zsh = "zsh",
  go = "go",
  rs = "rust",
  java = "java",
  c = "c",
  cpp = "cpp",
  cc = "cpp",
  cxx = "cpp",
  hpp = "cpp",
  cs = "cs",
  kt = "kotlin",
  kts = "kotlin",
  swift = "swift",
  dart = "dart",
  scala = "scala",
  pl = "perl",
  r = "r",
}

local function current_file()
  local path = vim.fn.expand("%:p")
  if path == "" then
    return nil
  end
  return path
end

local function detect_filetype(path)
  local filetype = vim.bo.filetype
  if filetype ~= "" and runners[filetype] then
    return filetype
  end

  local extension = vim.fn.fnamemodify(path, ":e"):lower()
  return extension_to_filetype[extension]
end

local function terminal_channel_from_window(winid)
  if not vim.api.nvim_win_is_valid(winid) then
    return nil
  end

  local buffer = vim.api.nvim_win_get_buf(winid)
  if vim.bo[buffer].buftype ~= "terminal" then
    return nil
  end

  local channel = vim.bo[buffer].channel
  if channel == nil or channel == 0 then
    return nil
  end

  return channel
end

local function has_floaterm()
  return vim.fn.exists(":FloatermToggle") == 2
end

local function send_to_builtin_terminal(command)
  vim.cmd("botright split | terminal")
  vim.schedule(function()
    local buffer = vim.api.nvim_get_current_buf()
    local channel = vim.bo[buffer].channel
    if channel == nil or channel == 0 then
      vim.notify("Could not open terminal channel", vim.log.levels.ERROR)
      return
    end
    vim.fn.chansend(channel, command .. "\n")
    vim.cmd("startinsert")
  end)
end

local function send_to_terminal(command)
  if not has_floaterm() then
    send_to_builtin_terminal(command)
    return
  end

  if vim.bo.buftype ~= "terminal" then
    vim.cmd("FloatermToggle")
  end

  vim.defer_fn(function()
    local channel = terminal_channel_from_window(vim.api.nvim_get_current_win())

    if channel == nil then
      for _, winid in ipairs(vim.api.nvim_list_wins()) do
        channel = terminal_channel_from_window(winid)
        if channel ~= nil then
          vim.api.nvim_set_current_win(winid)
          break
        end
      end
    end

    if channel == nil then
      vim.notify("Could not find Floaterm terminal channel", vim.log.levels.ERROR)
      return
    end

    vim.fn.chansend(channel, command .. "\n")
    vim.cmd("startinsert")
  end, 200)
end

function M.run()
  local command = M.build_command({ save = true, check_file = true })
  if command == nil then
    return
  end
  send_to_terminal(command)
end

function M.build_command(opts)
  opts = opts or {}
  local path = current_file()
  if path == nil then
    if opts.notify ~= false then
      vim.notify("No file to run", vim.log.levels.WARN)
    end
    return nil
  end

  if opts.save and vim.bo.modified then
    vim.cmd("write")
  end

  if opts.check_file ~= false then
    local stat = uv.fs_stat(path)
    if stat == nil or stat.type ~= "file" then
      if opts.notify ~= false then
        vim.notify("File does not exist: " .. path, vim.log.levels.ERROR)
      end
      return nil
    end
  end

  local filetype = detect_filetype(path)
  if filetype == nil then
    if opts.notify ~= false then
      vim.notify("No runner configured for this file", vim.log.levels.WARN)
    end
    return nil
  end

  local runner = runners[filetype]
  if runner == nil then
    if opts.notify ~= false then
      vim.notify("No runner configured for filetype: " .. filetype, vim.log.levels.WARN)
    end
    return nil
  end

  return runner(vim.fn.shellescape(path))
end

function M.copy_command()
  local command = M.build_command({ check_file = false })
  if command == nil then
    return
  end
  vim.fn.setreg("+", command)
  vim.notify("Copied: " .. command)
end

vim.api.nvim_create_user_command("Run", M.run, {
  desc = "Detect current file language and run it",
})

vim.api.nvim_create_user_command("RunCopy", M.copy_command, {
  desc = "Copy the runner command for the current file to clipboard",
})

vim.keymap.set("n", "<leader>r", M.run, { desc = "Run current file" })
vim.keymap.set("n", "<leader>rm", M.copy_command, { desc = "Copy runner command to clipboard" })

return M
