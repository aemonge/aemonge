--------------------------------------------------------------------------------------------------------------------------
--                                                    Code Completion                                                  |
--------------------------------------------------------------------------------------------------------------------------
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full"
vim.opt.completeopt = "longest,menuone,noselect,preview"
lvim.builtin.cmp.completion.completeopt = "longest,menuone,noselect,preview"
vim.keymap.set('i', '<c-h>', '<c-x><c-s>') -- Spelling completion
lvim.keys.normal_mode["<CR>"] = false

---------------------------------------------------------------------------
-- Lunar vim overrides
---------------------------------------------------------------------------
lvim.builtin.treesitter.ignore_install = {
  "c", "rust",
  "PHP", "java", "julia"
}
lvim.builtin.treesitter.ensure_installed = {
  "bash", "help",
  "javascript", "typescript",
  "css", "html", "lua", "markdown",
  "python", "ruby", "sql",
  "yaml", "json"
}

---------------------------------------------------------------------------
-- LSP and Treesitter
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "ray-x/lsp_signature.nvim",
 event = "BufRead",
 config = function() require"lsp_signature".setup({
   bind = true, -- This is mandatory, otherwise border config won't get registered.
   handler_opts = {
     border = "rounded",
   },
   hint_prefix = "💡",
   always_trigger = true,
   transparency=80,
   shadow_guibg='None'
 }) end
})
require("lvim.lsp.manager").setup("ltex", {
  cmd = { "ltex-ls" },
  filetypes = { "markdown", "text" },
  flags = { debounce_text_changes = 300 },
})

table.insert(lvim.plugins, { "romgrk/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup{
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      throttle = true, -- Throttles plugin updates (may improve performance)
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        default = {
          'class',
          'function',
          'method',
        },
      },
    }
  end
})

---------------------------------------------------------------------------
-- Tab-Nine (AI)
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "tzachar/cmp-tabnine",
  build = "./install.sh",
  dependencies = "hrsh7th/nvim-cmp",
  event = "InsertEnter",
})
lvim.builtin.cmp.experimental.ghost_text = true
table.insert(lvim.plugins, { "codota/tabnine-nvim",
  build = "./dl_binaries.sh",
  config = function()
    require("tabnine").setup({
      disable_auto_comment = true,
      accept_keymap="<C-l>",
      debounce_ms = 500,
      suggestion_color = {gui = '#8B6C91'},
      plugins = {
        cmp = true
      },
      use_short_prefix = true
    })
  end
})

---------------------------------------------------------------------------
-- Emoji
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "hrsh7th/cmp-emoji",
  dependencies = "hrsh7th/nvim-cmp"
})
