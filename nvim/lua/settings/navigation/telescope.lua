---- Telescope
local M = {}

local whichkey_opts = {
  mode = "n",
  prefix = nil,
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

table.insert(M, { 'nvim-telescope/telescope.nvim',
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",

    "kelly-lin/telescope-ag",
    "xiyaowong/telescope-emoji.nvim",
    "ghassan0/telescope-glyph.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local telescope = require("telescope")
    local actions = require "telescope.actions"

    telescope.load_extension("zf-native")
    telescope.load_extension("emoji")
    telescope.load_extension("glyph")
    telescope.load_extension("ag")
    telescope.load_extension("undo")

    telescope.setup {
      extensions = {
        glyph = {
          action = function(emoji)
            vim.api.nvim_put({ emoji.value }, 'c', false, true)
          end,
        },
        emoji = {
          action = function(emoji)
            vim.api.nvim_put({ emoji.value }, 'c', false, true)
          end,
        }
      },
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,

            ["<esc>"] = actions.close,

            ["<CR>"] = actions.select_default,
            ["<C-s>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.complete_tag,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
          },

          n = {
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-s>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.delete_buffer,

            ["?"] = actions.which_key,
          },
        },
      },
    }

    require "which-key".register({
      ["<c-p>"] = { ":Telescope find_files <cr>", "Files search in CWD" },
      ["<c-n>"] = { ":Telescope buffers sort_mru=1 ignore_current_buffer=1 initial_mode=insert <cr>", "Buffer list" },
      ["<c-f>"] = { ":Telescope live_grep <cr>", "Grep on files in CWD" },
      ["<leader>f"] = {
        "Telescope",
        a = { "<cmd>Telescope <CR>", "Built-in" },
        h = { "<cmd>Telescope help_tags <CR>", "Help" },
        u = { "<cmd>Telescope undo <CR>", "Undo" },
        t = { "<cmd>Telescope tags <CR>", "Tags" },
        e = { "<cmd>Telescope emoji <CR>", "Emoji"},
        g = { "<cmd>Telescope glyph <CR>", "Glyph"},

      },
    }, {
      mode = "n",
      prefix = nil,
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    })
  end
})

table.insert(M, { 'nvim-telescope/telescope-fzf-native.nvim',
  build = 'make'
})

---------------------------------------------------------------------------
-- Telescope Search on visual selection
---------------------------------------------------------------------------
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

vim.keymap.set( 'v', '<leader>f',
  ':<C-u>lua require("telescope.builtin.__files").grep_string({search="<C-R>=GetVisualSelection()<CR>"})<CR>',
  { buffer = nil, silent = true, noremap = true, nowait = true, }
)

return M
