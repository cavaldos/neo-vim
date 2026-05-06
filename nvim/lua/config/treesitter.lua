local M = {}

local parserInstallInFlight = {}
local notifiedMessages = {}

local function notifyOnce(message, level)
  if notifiedMessages[message] then
    return
  end

  notifiedMessages[message] = true
  vim.schedule(function()
    vim.notify(message, level, { title = "Treesitter" })
  end)
end

local function hasParser(language)
  return vim.treesitter.language.add(language, { silent = true })
end

local function installParser(language)
  if parserInstallInFlight[language] or hasParser(language) then
    return
  end

  parserInstallInFlight[language] = true

  notifyOnce(
    string.format(
      "Treesitter parser '%s' was not found. Neovim is installing it locally now.",
      language
    ),
    vim.log.levels.WARN
  )

  require("nvim-treesitter").install(language):await(function(error)
    parserInstallInFlight[language] = nil

    if error ~= nil then
      notifyOnce(
        string.format(
          "Failed to install Treesitter parser '%s'. Markdown rendering will stay disabled until installation succeeds.",
          language
        ),
        vim.log.levels.ERROR
      )
      return
    end

    notifyOnce(
      string.format(
        "Treesitter parser '%s' was installed successfully. Reopen the file if highlighting does not refresh automatically.",
        language
      ),
      vim.log.levels.INFO
    )
  end)
end

function M.ensureParser(language)
  if hasParser(language) then
    return true
  end

  installParser(language)
  return false
end

function M.ensureParsers(languages)
  for _, language in ipairs(languages) do
    M.ensureParser(language)
  end
end

function M.startBuffer(bufnr)
  local filetype = vim.bo[bufnr].filetype

  if filetype == "" then
    return false
  end

  if not M.ensureParser(filetype) then
    return false
  end

  local ok, errorMessage = pcall(vim.treesitter.start, bufnr)
  if ok then
    return true
  end

  local message = errorMessage
  if type(message) ~= "string" then
    message = tostring(message)
  end

  notifyOnce(
    string.format(
      "Treesitter could not start for '%s': %s",
      filetype,
      message
    ),
    vim.log.levels.WARN
  )

  return false
end

return M
