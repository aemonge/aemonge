--------------------------------------------------------------------------------------------------------------------------
--                                                    Terminal                                                           |
--------------------------------------------------------------------------------------------------------------------------
-- lvim.builtin.terminal.active = false
local t_mappings = {}
local n_mappings = {}

---------------------------------------------------------------------------
-- [neovim-remote](nvr): Close on Git Commit messages
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = {"gitrebase", "gitcommit", "diff"},
  command = "setlocal bufhidden=wipe"
})

---------------------------------------------------------------------------
--  Tips and helper
---------------------------------------------------------------------------
-- ls "%" | entr -rn ./"%" # where % is file
local function t(str) --TermCodes
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---------------------------------------------------------------------------
--  Functions Helpers
---------------------------------------------------------------------------
function ClearTerm(reset)
  vim.opt_local.scrollback = 0
  -- vim.o.scrollback = 1

  vim.api.nvim_command("startinsert")
  if reset == 1 then
    vim.api.nvim_command("silent! BWipeout! hidden")
    vim.api.nvim_feedkeys("reset", 't', false)
  else
    vim.api.nvim_feedkeys("clear", 't', false)
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 't', true)

  vim.opt_local.scrollback = 10000
end

function Tapi_Tabe(files)
  for file in string.gmatch(files, "[^%s]+") do
    vim.cmd(string.format("tabe %s", file))
  end
end

function Tapi_Cd(cwd)
  vim.cmd(string.format("cd %s", cwd))
end

function TerminalLocalOpts()
  vim.opt_local.title = true
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.showcmd = false
  vim.opt_local.wrap = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldenable = false
  vim.opt_local.spell = false
  vim.opt_local.ruler = false
  vim.cmd [[
    nnoremap <buffer> <C-f> <C-W>gf
    vnoremap <buffer> <C-f> <C-W>gf
  ]]
end

function NewTermTab(active)
  vim.api.nvim_command(":tabnew")
  StartTerm(0, active)
end

function OpenFileProject(args)
  for str in string.gmatch(args, "[^%s]+") do
    vim.cmd.tabe(str)
    vim.cmd(":LspRestart<cr>")
  end
end

function SplitTerm(horizontal, active)
  if horizontal == 1 then
    vim.api.nvim_command("split")
  else
    vim.api.nvim_command("vsplit")
  end
  StartTerm(0, active)
end

function StartTerm(first, active)
  vim.api.nvim_command("terminal")
  vim.cmd("setlocal bufhidden=delete")
  if first == 1 then
    -- NOTE: when only the term tab remains, clear all. To give the impression of closing vim.
    vim.api.nvim_create_autocmd("TermEnter", {
      callback = function()
        if vim.fn.tabpagenr('$') == 1 and #vim.fn.tabpagebuflist() == 1 then
          vim.cmd [[silent! BWipeout! other]]
        end
      end
    })
    vim.api.nvim_create_autocmd("TermClose", {
      callback = function()
        if vim.v.event.status == 0 then
          vim.cmd [[ q ]]
        end
      end
    })
  else
    vim.api.nvim_create_autocmd("TermClose", {
      callback = function()
        if vim.v.event.status == 0 then
          vim.cmd [[ exe 'silent! bdelete! '..expand('<abuf>')]]
        end
      end
    })
  end

  vim.api.nvim_command("startinsert")
  if active == 1 then
    vim.cmd [[ au BufEnter <buffer> :startinsert ]]
  end
end

lvim.autocommands = {
  {
    "TermOpen", {
      callback = TerminalLocalOpts
    }
  },
  { -- BUG: I should not need to re-call the local opts, but someone is resetting the sign-column.
    "TermEnter", {
      callback = TerminalLocalOpts
    }
  }
}

---------------------------------------------------------------------------
--  Terminal Mappings
---------------------------------------------------------------------------
table.insert(t_mappings, {
  ["<ESC><ESC>"] = { t '<C-\\><C-N>', "Go to normal mode" },
  -- ['<C-T>'] = { t '<C-\\><C-n>:lua NewTermTab(0)<cr>', "New soft-term tab" },

  ['<C-h>'] = { t '<C-\\><C-N>gT', "Previous Tab" },
  ['<C-k>'] = { t '<C-\\><C-N><C-w>w', "Next Buffer" },
  ['<C-j>'] = { t '<C-\\><C-N><C-w>W', "Previous Buffer" },

  ['<C-p>'] = { t 'nvr -cc "cd $(pwd) | Telescope find_files" <CR>', "Open files in CWD" },
  ['<C-t>'] = { t '<C-\\><C-n>:lua NewTermTab(1)<cr>', "New hard-term tab" },

  ['<C-l>'] = {
    name = "Cleaners",
    [''] = { [[<C-\><C-N>gt]], "Next Tab" },
    ['<C-l>'] = { [[<C-\><C-N>:lua ClearTerm(0)<CR>]], "Clear cmd" },
    ['<C-l><C-l>'] = { [[<C-\><C-N>:lua ClearTerm(1)<CR>]], "Clear and wipe history" }
  },
})

---------------------------------------------------------------------------
-- For Terminal Mappings
-- See: ./navigation.config.lua for split terminal
-- ["<c-w>"] = {
-- T = { ":lua SplitTerm(1, 1)<CR>", "Open term in hsplit" },
-- t = { ":lua SplitTerm(0, 1)<CR>", "Open term in vsplit" }
-- },
---------------------------------------------------------------------------
table.insert(n_mappings, {
  ['<c-t>'] = { ":lua NewTermTab(1)<cr>", "Open soft-term in tab" }
})

---------------------------------------------------------------------------
-- Register Mappings into Which Key
---------------------------------------------------------------------------
require "which-key".register(t_mappings, { buffer = nil, silent = true, noremap = true, nowait = true, mode = 't' })
require "which-key".register(n_mappings, { buffer = nil, silent = true, noremap = true, nowait = true, mode = 'n' })
-- lvim.builtin.which_key.opts = { buffer = nil, silent = true, noremap = true, nowait = true, mode = 'n' }
-- table.insert(lvim.builtin.which_key.mappings, n_mappings)

---------------------------------------------------------------------------
-- NOTE: Experimental

---------------------------------------------------------------------------
-- lvim.builtin.terminal.active = false -- Use **MY** settings bro 😠
-- lvim.builtin.terminal.setup()
table.insert(lvim.plugins, { "akinsho/toggleterm.nvim", -- version = "*",
  config = function()
    require("toggleterm").setup({
      -- SEE: https://github.com/akinsho/toggleterm.nvim
      hide_numbers = true, -- hide the number column in toggleterm buffers
      autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
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
        -- Normal = {
        --   guibg = "NONE",
        --   bg = "NONE",
        -- },
        -- FloatBorder = {
        --   guibg = "NONE",
        --   bg = "NONE",
        -- },
      },
      float_opts = {
        border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        width = 120,
        height = 35
      }
    })
  end
})

-- TODO: Check the send TermExec cmd='irb'
  require "which-key".register({
    ["<C-x>"] = { t '<C-\\><C-N>:ToggleTerm<Cr>', "Go to normal mode" },
  }, { mode = "t", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,})
require "which-key".register({
  ['<C-x>'] = { ":ToggleTerm direction=float<cr>", "Toggle float term" },
}, { mode = "n", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,})
require "which-key".register({
  ['<C-x>'] = { ":ToggleTermSendVisualSelection<cr>", "Send Visual selection to toggled term" },
}, { mode = "v", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,})
