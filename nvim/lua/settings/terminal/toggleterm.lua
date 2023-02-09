local M = {}

---------------------------------------------------------------------------
--  Tips and helper
---------------------------------------------------------------------------
-- ls "%" | entr -rn ./"%" # where % is file
local function t(str) --TermCodes
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

table.insert(M, { "akinsho/toggleterm.nvim", -- version = "*",
  config = function()
    local t_mappings = require "settings.terminal.mappings"

    require("toggleterm").setup({
      -- SEE: https://github.com/akinsho/toggleterm.nvim
      hide_numbers = true, -- hide the number column in toggleterm buffers
      autochdir = true, -- based on the current working directory of neovim
      on_open = function ()
        vim.api.nvim_command("startinsert")
      end,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = false, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = false,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float',
      close_on_exit = true, -- close the terminal window when the process exits
      auto_scroll = true, -- automatically scroll to the bottom on terminal output
      highlights = {
        Terminal = {
          guibg = "NONE",
          bg = "NONE",
        },
      },
      float_opts = {
        border = 'rounded',
        width = function()
          return math.floor(vim.o.columns * 0.85)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.85)
        end,
      }
    })

    require "which-key".register(t_mappings, {
      mode = "t", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true
    })
    require "which-key".register({
      ['<C-x>'] = { ":ToggleTerm direction=float<cr>", "Toggle float term" },
    }, {
      mode = "n", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,
    })
    require "which-key".register({
      ['<C-x>'] = { ":ToggleTermSendVisualSelection<cr>", "Send Visual selection to toggled term" },
    }, { mode = "v", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,})
  end
})

return M
