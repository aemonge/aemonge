-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/advance-usage.md
local M = {}

table.insert(M, { "williamboman/mason.nvim",
  config = function ()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
      }
    })
  end
})

table.insert(M, { 'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
  },
  config = function()
    local lsp = require('lsp-zero')
    lsp.set_preferences({
      suggest_lsp_servers = true,
      setup_servers_on_start = true,
      configure_diagnostics = true,
      cmp_capabilities = true,
      manage_nvim_cmp = false,
      call_servers = 'local',
      sign_icons = false,
      set_lsp_keymaps = {
        omit = {
          '<C-k>', '<Ctrl-k>'
        }
      },
    })

    lsp.setup()

    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        code = true,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = function(diagnostic)
          local code = diagnostic.code

          if code == nil then
            code = ''
          else
            code = '('.. code ..') '
          end

          if diagnostic.severity == vim.diagnostic.severity.ERROR then
            return '  ' .. code
          elseif diagnostic.severity == vim.diagnostic.severity.WARN then
            return '  ' .. code
          elseif diagnostic.severity == vim.diagnostic.severity.INFO then
            return '  ' .. code
          elseif diagnostic.severity == vim.diagnostic.severity.HINT then
            return ' 󱧢 ' .. code
          else
            return code
          end
        end
      },
    })

    function ClearSigns()
      vim.fn.sign_define("DiagnosticSignError", { text = '', numhl= "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",  { text = '', numhl= "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo",  { text = '', numhl= "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint",  { text = '', numhl= "DiagnosticSignHint" })
    end

    ClearSigns()
  end
})

table.insert(M, { "ray-x/lsp_signature.nvim",
  config = function ()
    cfg = {
      bind = true,
      doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                     -- set to 0 if you DO NOT want any API comments be shown
                     -- This setting only take effect in insert mode, it does not affect signature help in normal
                     -- mode, 10 by default

      max_height = 12, -- max height of signature floating_window
      max_width = 50, -- max_width of signature floating_window
      noice = true, -- set to true if you using noice to render markdown
      wrap = false, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap

      floating_window_off_x = 1, -- adjust float windows x position.
                                 -- can be either a number or function
      floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
                                  -- can be either number or function, see examples

      close_timeout = 4000, -- close floating window after ms when laster parameter is entered
      fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🤖",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
      hint_scheme = "String",
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      handler_opts = {
        border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
      },

      auto_close_after = 3, -- autoclose signature float win after x sec, disabled if nil.

      padding = '|', -- character to pad on left and right of signature can be ' ', or '|'  etc

      -- transparency = nil, -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 15, -- if you using shadow as border use this set the opacity
      timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = '<C-k>', -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
      select_signature_key = '<C-S-K>', -- cycle to next signature, e.g. '<M-n>' function overloading
    }

    -- recommended:
    require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key
  end
})

-- table.insert(M, { 'rmagatti/goto-preview',
--   config = function()
--     require('goto-preview').setup {
--       width = 60; -- Width of the floating window
--       height = 20; -- Height of the floating window
--       border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}; -- Border characters of the floating window
--       default_mappings = true; -- Bind default mappings
--       opacity = 20; -- 0-100 opacity level of the floating window where 100 is fully transparent.
--       resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
--       references = { -- Configure the telescope UI for slowing the references cycling window.
--         telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
--       };
--       -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
--       focus_on_open = true; -- Focus the floating window when opening it.
--       dismiss_on_move = true; -- Dismiss the floating window when moving the cursor.
--       force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
--       bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
--     }
--
--     require "which-key".register({
--       p = {
--         name = "Preview",
--         d = {"<cmd>lua require('goto-preview').goto_preview_definition()<CR>"     , "Definition"},
--         t = {"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "Type Definition"},
--         i = {"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>" , "Implementation"},
--         r = {"<cmd>lua require('goto-preview').goto_preview_references()<CR>"     , "References"},
--         k = {"<cmd>lua require('goto-preview').close_all_win()<CR>"               , "Kill Preview"},
--       }}, {
--         mode = "n",
--         prefix = "g",
--         buffer = nil,
--         silent = true,
--         noremap = true,
--         nowait = true,
--       }
--     )
--   end
-- })

return M
