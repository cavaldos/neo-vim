return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local configuration = vim.fn["gruvbox_material#get_configuration"]()
    local palette = vim.fn["gruvbox_material#get_palette"](
      configuration.background,
      configuration.foreground,
      configuration.colors_override
    )

    local config = {
      options = {
        component_separators = "",
        section_separators = "",
        theme = {
          normal = { c = { bg = palette.bg0[1], fg = palette.fg0[1] } },
          inactive = { c = { bg = palette.bg0[1], fg = palette.fg0[1] } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_y = {},
        lualine_z = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_y = {},
        lualine_z = {},
        lualine_x = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left({
      function()
        return "▊"
      end,
      color = { fg = palette.blue[1] },
      padding = { left = 0, right = 1 },
    })

    ins_left({
      function()
        return ""
      end,
      color = function()
        local mode_color = {
          n = palette.red[1],
          i = palette.green[1],
          v = palette.blue[1],
          [""] = palette.blue[1],
          V = palette.blue[1],
          c = palette.purple[1],
          no = palette.red[1],
          s = palette.orange[1],
          S = palette.orange[1],
          [""] = palette.orange[1],
          ic = palette.yellow[1],
          R = palette.purple[1],
          Rv = palette.purple[1],
          cv = palette.red[1],
          ce = palette.red[1],
          r = palette.aqua[1],
          rm = palette.aqua[1],
          ["r?"] = palette.aqua[1],
          ["!"] = palette.red[1],
          t = palette.red[1],
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    })

    ins_left({
      "filename",
      color = { fg = palette.purple[1], gui = "bold" },
    })

    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", hint = " ", info = " " },
    })

    ins_right({
      "branch",
      icon = "",
      color = { fg = palette.red[1], gui = "bold" },
    })

    ins_right({
      "diff",
      symbols = { added = " ", modified = " ", removed = " " },
    })

    ins_right({ "filetype" })

    ins_right({ "location" })

    ins_right({
      "progress",
      color = { fg = palette.fg1[1], gui = "bold" },
    })

    ins_right({
      function()
        return "▊"
      end,
      color = { fg = palette.blue[1] },
      padding = { left = 0 },
    })

    require("lualine").setup(config)
  end,
}
