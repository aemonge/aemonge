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
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local filetype = {
  "filetype",
  icons_enabled = true,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local M =  { 'nvim-lualine/lualine.nvim',
  config = function ()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { branch },
        lualine_b = { diagnostics },
        lualine_c = {
          { "diff" },
          { "nvim-tree" },
          { "filename", path = 1, shorting_target = 80 }
        },
        lualine_x = { diff,  filetype },
      },
      inactive_sections = {
        lualine_a = { branch },
        lualine_b = {},
        lualine_c = {
          { "diff" },
          { "filename", path = 1, shorting_target = 80 }
        },
        lualine_x = { diff,  filetype },
      },
      disabled_filetypes = { "", "NvimTree", "Outline", "terminal" },
      disabled_buftypes = { "", "terminal", "quickfix", "prompt" },
    }
  end
}

return M
