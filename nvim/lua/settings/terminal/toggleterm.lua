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
    require("toggleterm").setup({
      -- SEE: https://github.com/akinsho/toggleterm.nvim
      hide_numbers = true, -- hide the number column in toggleterm buffers
      autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
      on_open = function ()
        vim.api.nvim_command("startinsert")
        TerminalLocalOpts()
      end,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = false, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
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
        border = 'curved',
        width = 120,
        height = 35
      }
    })

    require "which-key".register({
      ["<C-x>"] = { t '<C-\\><C-N>:ToggleTerm<Cr>', "Go to normal mode" },
    }, { mode = "t", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true})
    require "which-key".register({
      ['<C-x>'] = { ":ToggleTerm direction=float<cr>", "Toggle float term" },
    }, { mode = "n", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,})
    require "which-key".register({
      ['<C-x>'] = { ":ToggleTermSendVisualSelection<cr>", "Send Visual selection to toggled term" },
    }, { mode = "v", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,})

    require "which-key".register(t_mappings, { buffer = nil, silent = true, noremap = true, nowait = true, mode = 't' })
    require "which-key".register(n_mappings, { buffer = nil, silent = true, noremap = true, nowait = true, mode = 'n' })
  end
})

return M
