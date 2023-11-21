local function search_count()
  if vim.api.nvim_get_vvar("hlsearch") == 1 then
    local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })

    if res.total > 0 then
      return string.format("%d/%d", res.current, res.total)
    end
  end

  return ""
end

local function get_mode_symbol()
  local mode = vim.api.nvim_get_mode().mode
  local mode_symbol = {
    ["n"] = { symbol = "", color = { fg = "#FF00FF" } }, -- Use default
    ["i"] = { symbol = "", color = { fg = "#628B4A" } }, -- Use pale blue color
    ["r"] = { symbol = "", color = { fg = "#D16969" } }, -- Use pale red color
    ["v"] = { symbol = "", color = { fg = "#E5C07B" } }, -- Use pale yellow color
    ["V"] = { symbol = "", color = { fg = "#E5C07B" } }, -- Use pale yellow color
    ["s"] = { symbol = "", color = { fg = "#EBCB8B" } }, -- Use dark yellow color
    ["c"] = { symbol = "", color = { fg = "#D16969" } }, -- Use dark red color
    ["t"] = { symbol = "", color = { fg = "#FF00FF" } }, -- Use default
    ["R"] = { symbol = "", color = { fg = "#FF75A8" } }, -- Use pink color
    ["!"] = { symbol = "", color = { fg = "#98C379" } }, -- Use pale green
  }

  return mode_symbol[mode] and mode_symbol[mode].symbol or ""
end


local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic", "coc" },
  sections = { 'error', 'warn' },
  symbols = { warn = ' ', error = ' ', info = '', hint = '𥉉' },
  colored = true,
  update_in_insert = true,
  always_visible = true,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local M = {
  "nvim-lualine/lualine.nvim",
  config = function()
    local disabled_filetypes, disabled_buftypes = require("settings.visual.raw-types")
    local material_theme = require("lualine.themes.material")

    local theme = {
      normal = {
        a = { fg = '#CCCECF', bg = '#2E3C43' },
        b = material_theme.normal.a,
        c = { fg = '#CCCECF', bg = '#4F596E' },
        x = { fg = '#CCCECF', bg = '#4F596E' },
        y = { fg = '#CCCECF', bg = '#4F596E' },
        z = material_theme.normal.z
      },
      inactive = {
        a = { fg = '#CCCECF', bg = '#353C4A' },
        c = { fg = '#CCCECF', bg = '#353C4A' },
        y = { fg = '#CCCECF', bg = '#353C4A' },
      }
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = disabled_filetypes,
        disabled_buftypes = disabled_buftypes,
      },
      sections = {
        lualine_a = { { get_mode_symbol, colored = true }, diff },
        lualine_b = { branch },
        lualine_c = {
          { "nvim-tree" },
          { "filename", path = 1 },
        },
        lualine_x = {},
        lualine_y = {
          {
            'g:coc_status',
            'b:coc_current_function',
            'bo:filetype',
          },
          diagnostics,
        },
        lualine_z = {
          { search_count, type = "lua_expr" },
          {
            "swenv",
            cond = function()
              return vim.bo.filetype == "python"
            end,
            icon = "",
            color = { fg = '#3B4252', bg = '#7E98BA' }
          }
        }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {},
        lualine_y = {
          "filetype", "filesize"
        },
        lualine_z = {},
      }
    })
  end,
}

return M
