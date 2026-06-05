---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everforest",
  hl_override = {
    CursorLineNr = {
      fg = "#FFA500",
      bold = true,
    },
  },
}

M.ui = {
  tabufline = {
    enabled = true,
    lazyload = false, 
  },
}

return M
