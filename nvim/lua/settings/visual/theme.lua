--------------------------------------------------------------------------------------------------------------------------
--                                                      Theme 🎨                                                         |
--------------------------------------------------------------------------------------------------------------------------
local M = {}
---------------------------------------------------------------------------
--  Theme: https://github.com/EdenEast/nightfox.nvim
--    DroidSans-Mono-Nerd-Font or InconsolataLGC
---------------------------------------------------------------------------
table.insert(M, { "EdenEast/nightfox.nvim",
  priority = 99999,
  config = function()
    require('nightfox').setup({
      options = {
        transparent = true,     -- Disable setting background
        terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = true,    -- Non focused panes set to alternative background
        module_default = true,   -- Default enable value for modules
        inverse = {             -- Inverse highlight for different types
          match_paren = true,
          search = false,
        },
        module_default = true,
        modules = {             -- List of various plugins and additional options
          -- aerial = true, barbar = true, coc = true, fern = true, fidget = true, illuminate = true, pounce = true,
          -- lightspeed = true, dashboard = true, mini = true, navic = true, neogit = true, neotest = true,

          cmp = true, diagnostic = true, gitgutter = true, gitsigns = true, glyph_palette = true, hop = true, lsp_saga = true,
          lsp_trouble = true, modes = true, native_lsp = true, neotree = true, notify = true, nvimtree = true, telescope = true,
          treesitter = true, whichkey = true, ['dap-ui'] = true,

          -- signify = true, sneak = true, symbol_outline = true, tsrainbow = true, tsrainbow2 = true,
        },
      },
      groups = {
        nordfox = {
          NormalNC = { bg = "NONE", fg = "#7e8188" },
          NormalFloat = { bg = "NONE" },
          FloatShadowThrough = { bg = "NONE" },
          CursorLine = { bg =  "NONE", style = "bold" },
          CursorColumn = { bg =  "NONE", style = "bold" },
          NonText = { bg = "NONE" },
          Terminal = { bg = "NONE" },
          Normal = { bg = "NONE" },
          Folded = { bg = "NONE" },
          Pmenu = { bg = "NONE" },
          lualine_c_normal = { bg = "#232831" },
          lualine_b_normal = { bg = "#232831" },
          CursorLineNr = { fg = "NONE" }
        }
      }
    })
    vim.cmd('colorscheme nordfox')
    vim.cmd[[
      hi WhichKeyFloat blend=15
    ]]
  end
})

return M
