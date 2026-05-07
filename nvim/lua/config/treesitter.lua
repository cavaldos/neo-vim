local M = {}

local parserInstallInFlight = {}
local notifiedMessages = {}
local ignoredFiletypes = {
  ["TelescopePrompt"] = true,
  ["alpha"] = true,
  ["checkhealth"] = true,
  ["fugitive"] = true,
  ["help"] = true,
  ["lazy"] = true,
  ["lspinfo"] = true,
  ["mason"] = true,
  ["neo-tree"] = true,
  ["notify"] = true,
  ["qf"] = true,
}

local ignoredBuftypes = {
  ["help"] = true,
  ["nofile"] = true,
  ["prompt"] = true,
  ["quickfix"] = true,
  ["terminal"] = true,
}

local function notifyOnce(message, level)
  if notifiedMessages[message] then
    return
  end

  notifiedMessages[message] = true
  vim.schedule(function()
    vim.notify(message, level, { title = "Treesitter" })
  end)
end

local function hasTreeSitterCli()
  return vim.fn.executable("tree-sitter") == 1
end

local function errorMessageText(error)
  if type(error) == "string" then
    return error
  end

  return tostring(error)
end

local function isMissingCliError(error)
  local message = errorMessageText(error):lower()

  return message:match("enoent") ~= nil
    or message:match("tree%-sitter") ~= nil
    or message:match("not found") ~= nil
    or message:match("executable") ~= nil
end

local function isMissingParserError(error)
  local message = errorMessageText(error):lower()

  return message:match("no parser") ~= nil
    or message:match("cannot find parser") ~= nil
    or message:match("parser.*not available") ~= nil
    or message:match("parser.*missing") ~= nil
    or message:match("invalid node type") ~= nil
    or message:match("query error") ~= nil
end

local function resolveLanguage(filetype)
  local ok, language = pcall(vim.treesitter.language.get_lang, filetype)
  if not ok or type(language) ~= "string" or language == "" then
    return filetype
  end

  return language
end

local function getPluginParserPath(language)
  local parserDirectory = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "parser")
  return vim.fs.joinpath(parserDirectory, language .. ".so")
end

local function canReadParser(path)
  return vim.uv.fs_stat(path) ~= nil
end

local function parserIsUsable(language)
  local ok = pcall(vim.treesitter.language.inspect, language)
  return ok
end

local function loadParser(language, path)
  local ok = pcall(vim.treesitter.language.add, language, { path = path, silent = true })
  if not ok then
    return false
  end

  return parserIsUsable(language)
end

local function hasParser(language)
  local pluginParserPath = getPluginParserPath(language)
  if canReadParser(pluginParserPath) then
    local ok = loadParser(language, pluginParserPath)
    if ok then
      return true, "plugin"
    end

    notifyOnce(
      string.format(
        "Treesitter parser '%s' from the local plugin install is broken. Falling back to the system parser.",
        language
      ),
      vim.log.levels.WARN
    )
  end

  if loadParser(language, nil) then
    return true, "system"
  end

  return false, nil
end

local function shouldIgnoreBuffer(bufnr, filetype)
  local buftype = vim.bo[bufnr].buftype

  if ignoredBuftypes[buftype] or ignoredFiletypes[filetype] then
    return true
  end

  return false
end

local function notifyMissingParser(language)
  notifyOnce(
    string.format(
      "Treesitter parser '%s' is not available. Treesitter features for this file will stay disabled.",
      language
    ),
    vim.log.levels.WARN
  )
end

local function notifyMissingCli(language)
  notifyOnce(
    string.format(
      "Treesitter parser '%s' is not available and the 'tree-sitter' CLI is not installed. Treesitter features for this file will stay disabled.",
      language
    ),
    vim.log.levels.WARN
  )
end

local function installParser(language)
  local parserAvailable = hasParser(language)
  if parserInstallInFlight[language] or parserAvailable then
    return
  end

  if not hasTreeSitterCli() then
    notifyMissingCli(language)
    return
  end

  local okModule, treesitter = pcall(require, "nvim-treesitter")
  if not okModule then
    notifyOnce(
      string.format("Failed to load nvim-treesitter while installing '%s': %s", language, errorMessageText(treesitter)),
      vim.log.levels.ERROR
    )
    return
  end

  if type(treesitter.install) ~= "function" then
    notifyOnce(
      string.format("nvim-treesitter install API is unavailable for parser '%s'.", language),
      vim.log.levels.ERROR
    )
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

  local okInstall, installResult = pcall(treesitter.install, language)
  if not okInstall then
    parserInstallInFlight[language] = nil

    if isMissingCliError(installResult) then
      notifyMissingCli(language)
      return
    end

    notifyOnce(
      string.format(
        "Failed to start Treesitter parser installation for '%s': %s",
        language,
        errorMessageText(installResult)
      ),
      vim.log.levels.ERROR
    )
    return
  end

  if type(installResult) ~= "table" or type(installResult.await) ~= "function" then
    parserInstallInFlight[language] = nil

    if hasParser(language) then
      notifyOnce(
        string.format(
          "Treesitter parser '%s' was installed successfully. Reopen the file if highlighting does not refresh automatically.",
          language
        ),
        vim.log.levels.INFO
      )
      return
    end

    notifyOnce(
      string.format(
        "Treesitter parser '%s' installation was started, but Neovim could not track completion on this version. Reopen the file after installation finishes.",
        language
      ),
      vim.log.levels.WARN
    )
    return
  end

  installResult:await(function(error)
    parserInstallInFlight[language] = nil

    if error ~= nil then
      if isMissingCliError(error) then
        notifyMissingCli(language)
        return
      end

      notifyOnce(
        string.format(
          "Failed to install Treesitter parser '%s'. Treesitter features for this file will stay disabled until installation succeeds.",
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

function M.hasParser(language)
  local parserAvailable, source = hasParser(language)
  if parserAvailable and source == "system" then
    notifyOnce(
      string.format(
        "Treesitter parser '%s' is using the system fallback because no local plugin parser is available.",
        language
      ),
      vim.log.levels.INFO
    )
  end

  return parserAvailable
end

function M.bufferHasParser(bufnr)
  local filetype = vim.bo[bufnr].filetype
  if filetype == "" then
    return false
  end

  local language = resolveLanguage(filetype)
  return M.hasParser(language)
end

function M.ensureParser(language)
  local parserAvailable = M.hasParser(language)
  if parserAvailable then
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

  if filetype == "" or shouldIgnoreBuffer(bufnr, filetype) then
    return false
  end

  local language = resolveLanguage(filetype)
  if not M.ensureParser(language) then
    notifyMissingParser(language)
    return false
  end

  local ok, errorMessage = pcall(vim.treesitter.start, bufnr, language)
  if ok then
    return true
  end

  if isMissingParserError(errorMessage) then
    installParser(language)
    notifyMissingParser(language)
    return false
  end

  if isMissingCliError(errorMessage) then
    notifyMissingCli(language)
    return false
  end

  local message = errorMessageText(errorMessage)

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
