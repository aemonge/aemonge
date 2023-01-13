--------------------------------------------------------------------------------------------------------------------------
--                                                   Visual Aids                                                         |
--------------------------------------------------------------------------------------------------------------------------
local textwidth = 120
vim.g.tex_conceal = "admgs"
vim.opt.concealcursor = "v"
vim.opt.conceallevel = 1     -- When text is marked as rich text “hidden characters”
vim.opt.cursorcolumn = true  -- Display vertical and horizontal current line
vim.opt.cursorline = true    -- Display vertical and horizontal current line
vim.opt.foldenable = false   -- keep inits easy to read
vim.opt.linebreak = false    -- Wrap long lines at a blank
vim.opt.list = true          -- Show these tabs and spaces and so on
vim.opt.matchtime = 2        -- Decrease the time to blink
vim.opt.scrolloff = 0        -- Avoid having a weird padding while moving with L H
vim.opt.showmatch = true     -- Show matching brackets/parenthesis
vim.opt.sidescroll = 1       -- Minimal number of columns to scroll horizontally
vim.opt.textwidth = textwidth
vim.opt.title = true         -- Set title
vim.opt.wrap = true          -- keep inits easy to read
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

---------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "p00f/nvim-ts-rainbow" })
table.insert(lvim.plugins, { "lcheylus/overlength.nvim",
  config = function ()
    require"overlength".setup({
      bg = "#692f2c",
      textwidth_mode = 1,
      default_overlength = textwidth,
      grace_length = 5,
      disable_ft = { 'qf', 'help', 'man', 'packer', 'NvimTree', 'Telescope', 'WhichKey', 'html', '', 'markdown' },
    })
  end
})
table.insert(lvim.plugins, { "junegunn/limelight.vim",
  config = function ()
    vim.g.limelight_default_coefficient = 0.7
    vim.g.limelight_paragraph_span = 2
    vim.g.limelight_priority = -1
  end
})
vim.g.limelight_default_coefficient = 0.7
vim.g.limelight_paragraph_span = 2
vim.g.limelight_priority = -1

---------------------------------------------------------------------------
--  Settings
---------------------------------------------------------------------------
lvim.builtin.indentlines.options.show_current_context_start = true -- Highlight Indent levels "indent_blankline"
lvim.lsp.diagnostics.virtual_text = false                          -- Hide diagnostics and show on gl (go line)

---------------------------------------------------------------------------
--  Treesitter
---------------------------------------------------------------------------
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.highlight.enabled = true
