local function split(input, delimiter)
  local arr = {}
  string.gsub(input, '[^' .. delimiter .. ']+', function(w) table.insert(arr, w) end)
  return arr
end

local function get_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv then
    local params = split(venv, '/')
    return ' ' .. params[table.getn(params) - 1] .. ''
  else
    return ''
  end
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local M = {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = "material",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { branch },
        lualine_b = { diagnostics },
        lualine_c = {
          { "nvim-tree" },
          { "filename", path = 1, shorting_target = 80 }
        },
        lualine_x = { diff },
        lualine_y = {
          get_venv,
          "require'lsp-status'.status()",
          filetype
        },
        lualine_z = { 'os.date("%I:%M:%S", os.time())' },
      },
      inactive_sections = {
        lualine_a = { branch },
        lualine_b = {},
        lualine_c = {
          { "filename", path = 1, shorting_target = 80 }
        },
        lualine_x = {},
        lualine_y = { filetype },
        lualine_z = {},
      },
      disabled_filetypes = { "", "NvimTree", "Outline", "terminal" },
      disabled_buftypes = { "", "terminal", "quickfix", "prompt", "terminal" },
    }
  end
}

return M
