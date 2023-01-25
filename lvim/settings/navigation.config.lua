--------------------------------------------------------------------------------------------------------------------------
--                                           Navigation, Motions and Search                                              |
--------------------------------------------------------------------------------------------------------------------------
local mappings = {}
local whichkey_opts = {
  mode = "n",
  prefix = nil,
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}
local mapping_opts = {
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

---------------------------------------------------------------------------
--  File Explorer
---------------------------------------------------------------------------
local NvimTreeMappings = ({
  -- IO.File operations
  { key = "c", action = "copy.node" },
  { key = "D", action = "remove" },
  { key = "a", action = "create" },
  { key = "d", action = "trash" },
  { key = "e", action = "full_rename" },
  { key = "p", action = "paste" },
  { key = "x", action = "cut" },

  -- Tree View Settings
  { key = "C", action = "cd" },
  { key = "q", action = "close" },
  { key = "r", action = "refresh" },
  { key = "z", action = "collapse_all" },
  { key = "u", action = "dir_up" },
  { key = "m", action = "toggle_mark" },

  -- Motions
  -- { key = "/", action = "search_node" },
  -- { key = "H", action = nil },

  -- Opening Actions
  { key = 't', action = "tabnew" },
  { key = { "<CR>", "o" }, action = "edit_no_picker", mode = "n" },
  { key = "Z", action = "expand_all" },
  { key = "s", action = "split" },
  { key = "S", action = "vsplit" },

  -- Copy actions
  { key = "Y",  action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  { key = "y",  action = "copy_name" },

  -- Default settings: Toggles
  { key = "<c-f>",  action = "telescope_find_files" },
  { key = "f", action = "live_filter" },
  { key = ".", action = "run_file_command" },
  { key = "U", action = "toggle_custom" },
  { key = "I", action = "toggle_dotfiles" },
  { key = "<C-k>", action = "toggle_file_info" },
  { key = "i", action = "toggle_git_ignored" },
  { key = "M", action = "toggle_mark" }
})
lvim.builtin.nvimtree.on_config_done = function ()
  local api = require("nvim-tree.api")
  local Event = api.events.Event

  api.events.subscribe(Event.TreeClose, function()
    vim.cmd[[FocusDisable]]
    vim.cmd[[FocusEnable]]
  end)
end
lvim.builtin.nvimtree.setup.remove_keymaps = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.auto_reload_on_write = true
lvim.builtin.nvimtree.setup.filters.dotfiles = true
-- lvim.builtin.nvimtree.setup.filters.no_buffer = true
-- lvim.builtin.nvimtree.setup.git.ignore = true
lvim.builtin.nvimtree.setup.view.width = 50
lvim.builtin.nvimtree.setup.view.mappings.list = NvimTreeMappings

---------------------------------------------------------------------------
--  Split Resize
---------------------------------------------------------------------------
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.equalalways = false -- Not set the split to equal sizes

table.insert(mappings, {
  ["<c-w>"] = {
    name = "Split and Resize",

    h = { ":FocusSplitLeft<cr>" , "Split left"},
    j = { ":FocusSplitDown<cr>", "Split down" },
    k = { ":FocusSplitUp<cr>", "Split up" },
    l = { ":FocusSplitRight<cr>", "Split Right" },

    d = { ":tabc<cr>", "Tab Close" },

    T = { ":lua SplitTerm(1, 1)<CR>", "Open term in hsplit" },
    t = { ":lua SplitTerm(0, 1)<CR>", "Open term in vsplit" },

    m = { ":FocusMaxOrEqual<CR>", "Focus toggle maximize" },
    M = { ":FocusMaximise<CR>", "Focus toggle maximize" },
    O = { ":BWipeout! other<CR>", "Close all other buffers" },

    n = { ":+tabmove <CR>" , "Move tab to next"},
    p = { ":-tabmove <CR>" , "Move tab to previous"},
    ['9'] = { ":tabmove <CR>" , "Move tab to Last"},
    ['0'] = { ":0tabmove <CR>" , "Move tab to first"},
    ['='] = { ":FocusEqualise<CR>", "Focus equalise buffers" },

    s = nil,
    v = nil,
  },
  ['_'] = { ":resize -2<cr>", "Decrease Horizontally" },
  ['+'] = { ":resize +3<cr>" , "Increase Horizontally"},
  ['='] = { ":vertical resize -2<cr>" , "Decrease Vertically"},
  ['-'] = { ":vertical resize +3<cr>" , "Increase Vertically"}
})

table.insert(lvim.plugins,  { 'beauwilliams/focus.nvim',
  init = function() require("focus").setup({
    excluded_buftypes = { 'qf', 'scratch', 'help', 'prompt', 'popup' },
    excluded_filetypes = { '', 'NvimTree', 'Telescope', 'WhichKey', 'toggleterm', 'TelescopePrompt' },
    compatible_filetrees = { 'NVimTree' },
    number = false,
    hybridnumber = true,
    -- autoresize = true,
    absolutenumber_unfocussed = true,
    width = 120,
    height = 40,
    treewidth = 30,
    quickfixheight = 20
  }) end
})

---------------------------------------------------------------------------
--  Tabs and buffers
---------------------------------------------------------------------------
lvim.builtin.bufferline.options.enforce_regular_tabs = true
lvim.builtin.bufferline.options.sort_by = "tabs"
lvim.builtin.bufferline.options.mode = "tabs"

table.insert(lvim.plugins, { "kazhala/close-buffers.nvim" })
table.insert(mappings, {
  ["<c-h>"] = { "<c-w><Left>" , "Go left"},
  ["<c-j>"] = { "<c-w><Down>" , "Go down"},
  ["<c-k>"] = { "<c-w><Up>" , "Go up"},
  ["<c-l>"] = { "<c-w><Right>" , "Go right"},

  ["<c-j><c-j>"] = { "gT" , "Previous tab"},
  ["<c-k><c-k>"] = { "gt" , "Next tab"},
})
---------------------------------------
--  On Terminal
---------------------------------------

local function t(str) --TermCodes
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end
t_mappings = {
  ['<C-j><C-j>'] = { t '<C-\\><C-N>gT', "Previous Tab" },
  ['<C-k><C-k>'] = { t '<C-\\><C-N>gt', "Next Tab" },

  ["<c-h>"] = { t '<C-\\><C-N><c-w><Left>' , "Go left"},
  ["<c-j>"] = { t '<C-\\><C-N><c-w><Down>' , "Go down"},
  ["<c-k>"] = { t '<C-\\><C-N><c-w><Up>' , "Go up"},
  ["<c-l>"] = { t '<C-\\><C-N><c-w><Right>' , "Go right"},
}

require "which-key".register(t_mappings, { buffer = nil, silent = true, noremap = true, nowait = true, mode = 't' })

---------------------------------------------------------------------------
--  Camel Case Motion
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "bkad/CamelCaseMotion",
  config = function ()
    vim.keymap.set('', 'w', '<Plug>CamelCaseMotion_w', mapping_opts)
    vim.keymap.set('', 'b', '<Plug>CamelCaseMotion_b', mapping_opts)
    vim.keymap.set('', 'e', '<Plug>CamelCaseMotion_e', mapping_opts)
    vim.keymap.set('', 'ge', '<Plug>CamelCaseMotion_ge', mapping_opts)
    vim.keymap.del('s', 'w')
    vim.keymap.del('s', 'b')
    vim.keymap.del('s', 'e')
    vim.keymap.del('s', 'ge')
    vim.keymap.set('o', 'iw', '<Plug>CamelCaseMotion_iw', mapping_opts)
    vim.keymap.set('x', 'iw', '<Plug>CamelCaseMotion_iw', mapping_opts)
    vim.keymap.set('o', 'ib', '<Plug>CamelCaseMotion_ib', mapping_opts)
    vim.keymap.set('x', 'ib', '<Plug>CamelCaseMotion_ib', mapping_opts)
    vim.keymap.set('o', 'ie', '<Plug>CamelCaseMotion_ie', mapping_opts)
    vim.keymap.set('x', 'ie', '<Plug>CamelCaseMotion_ie', mapping_opts)
  end
})
table.insert(lvim.plugins, { "phaazon/hop.nvim",
  event = "BufRead",
  dependencies = "folke/which-key.nvim",
  config = function()
    require("hop").setup()
    require "which-key".register({
      s = { ":HopChar2<cr>", "Hop to first two chars"},
      S = { ":HopPattern<cr>", "Hop to patter" }
    }, whichkey_opts)
  end,
})

---------------------------------------------------------------------------
--  Telescope Plugin: Undo navigation
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "debugloop/telescope-undo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("undo")
  end,
})

-- table.insert(lvim.plugins, { "nvim-telescope/telescope-fzy-native.nvim",
  -- dependencies = { "nvim-telescope/telescope.nvim" },
  -- build = "make",
  -- event = "BufRead",
-- })

table.insert(lvim.plugins, { "kelly-lin/telescope-ag",
  dependencies = { "nvim-telescope/telescope.nvim" }
})
---------------------------------------------------------------------------
-- Telescope Search
---------------------------------------------------------------------------
table.insert(mappings, {
  ["<c-p>"] = { ":Telescope find_files <cr>", "Files search in CWD" },
  ["<c-n>"] = { ":Telescope buffers sort_mru=1 ignore_current_buffer=1 initial_mode=insert <cr>", "Buffer list" },
  ["<c-f>"] = { ":Telescope live_grep <cr>", "Grep on files in CWD" },
  ["<leader>f"] = { "<cmd>Telescope <CR>", "Telescope All" },
})
lvim.builtin.which_key.mappings['f'] = nil
lvim.builtin.telescope.defaults.mappings = {
  n = {
    ["<esc>"] = require('telescope.actions').close,
  },
  i = {
    ["<esc>"] = require('telescope.actions').close,
  }
}

---------------------------------------------------------------------------
-- Telescope Search on visual selection
---------------------------------------------------------------------------
lvim.keys.visual_mode["<leader>f"] = "y<esc>q:pITelescope grep_string search=<cr>"
vim.keymap.set('v', '<leader>f', 'y<esc>q:pITelescope grep_string search=<cr>', mapping_opts)
vim.cmd [[
  func! GetVisualSelection() abort
      let [lnum1, col1] = getpos("'<")[1:2]
      let [lnum2, col2] = getpos("'>")[1:2]
      let lines = getline(lnum1, lnum2)
      if len(lines) == 0
          return ''
      endif
      let lines[-1] = lines[-1][: col2 - (&selection ==# 'inclusive' ? 1 : 2)]
      let lines[0] = lines[0][col1 - 1:]
      return join(lines, "\n")
  endf
  xnoremap * :<C-u>let @/ = GetVisualSelection()<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>let @/ = GetVisualSelection()<CR>?<C-R>=@/<CR><CR>
]]
vim.keymap.set(
  'v', '<leader>f',
  ':<C-u>lua require("telescope.builtin.__files").grep_string({search="<C-R>=GetVisualSelection()<CR>"})<CR>',
  mapping_opts
)

---------------------------------------------------------------------------
-- Register Mappings into Which Key
---------------------------------------------------------------------------
-- lvim.builtin.which_key.opts = whichkey_opts
-- table.insert(lvim.builtin.which_key.mappings, mappings)
require "which-key".register(mappings, whichkey_opts)
