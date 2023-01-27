--------------------------------------------------------------------------------------------------------------------------
--                                                      Theme 🎨                                                         |
--------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------
--  Theme: https://github.com/EdenEast/nightfox.nvim
--    DroidSans-Mono-Nerd-Font or InconsolataLGC
---------------------------------------------------------------------------
table.insert(plugins, { "EdenEast/nightfox.nvim",
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
          CursorLine = { bg =  "NONE", style = "bold" },
          CursorColumn = { bg =  "NONE", style = "bold" },
          NonText = { bg = "NONE" },
          Terminal = { bg = "NONE" },
          Normal = { bg = "NONE" },
          Folded = { bg = "NONE" },
          CursorLineNr = { fg = "NONE" }
        }
      }
    })
    vim.cmd('colorscheme nordfox')

    vim.cmd[[
      hi CursorLine   gui=bold      cterm=bold 
      hi CursorColumn gui=bold      cterm=bold 
    ]]
  end
})

---------------------------------------------------------------------------
-- [NordFox] plugin/syntax.vim: Output the highlight group under the cursor 
---------------------------------------------------------------------------
vim.cmd[[
  function! SynStack()
    for i1 in synstack(line("."), col("."))
      let i2 = synIDtrans(i1)
      let n1 = synIDattr(i1, "name")
      let n2 = synIDattr(i2, "name")
      echo n1 "->" n2
    endfor
  endfunction

  map <F2> <cmd>call SynStack()<cr>
]]

---------------------------------------------------------------------------
--  Lualine
---------------------------------------------------------------------------
-- lvim.builtin.lualine.options.disabled_buftypes = { 'terminal', 'quickfix', 'prompt' }
-- lvim.builtin.lualine.options.disabled_filetypes = { 'terminal' }
-- lvim.builtin.lualine.sections.lualine_c = {
  -- { "aerial" },
  -- { "chadtree" },
  -- { "fugitive" },
  -- { "pythonenv" },
  -- { "diff" },
  -- { "nvim-dap-ui" },
  -- { "nvim-tree" },
  -- { "filename",
    -- path = 1, shorting_target = 80
  -- }
-- }

-- lvim.builtin.lualine.options.icons_enabled = true
-- lvim.builtin.lualine.on_config_done = function(lualine)
  -- local config = lualine.get_config()
  -- table.remove(config.sections.lualine_x, 2) -- Remove the LSP info
  -- -- table.insert(config.sections.lualine_x,  3, { "tabnine" })
  -- lualine.setup(config)
-- end
