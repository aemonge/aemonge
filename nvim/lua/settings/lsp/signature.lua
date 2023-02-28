local M = {}

table.insert(M, { "ray-x/lsp_signature.nvim",
  config = function ()
    local cfg = {
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

return M
