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
vim.opt.textwidth = 0        -- Don't use the textwidth relay on overlength to display the warning
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
      disable_ft = {
        '', 'terminal', 'qf', 'help', 'man', 'scratch',
        'packer', 'NvimTree', 'Telescope', 'WhichKey',
        'html', 'markdown', 'text',
      }
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
-- Image Viewer
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "princejoogie/chafa.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "m00qek/baleia.nvim"
  },
})
---------------------------------------------------------------------------
--  Vimade: Lower the none active buffer brightness
---------------------------------------------------------------------------
-- table.insert(lvim.plugins, { "TaDaa/vimade",
--   config = function ()
--     vim.g.vimade.fadelevel = 0.8
--     vim.g.vimade.enablesigns = 0
--     vim.g.vimade.fademinimap = 0
--     vim.g.vimade.enabletreesitter  = 1
--   end
-- })

---------------------------------------------------------------------------
--  Settings
---------------------------------------------------------------------------
lvim.builtin.indentlines.options.show_current_context_start = true -- Highlight Indent levels "indent_blankline"
lvim.lsp.diagnostics.virtual_text = false                          -- Hide diagnostics and show on gl (go line)
-- Only display the git error icons, and for the rest simple change the color of the line number, have a less obstructive UI
function ClearSigns(hideGitSigns)
  -- No Icons for git changes
  if hideGitSigns == 1  then
    vim.fn.sign_define("GitSignsAdd",          { text = '', numhl= "GitSignsAdd" })
    vim.fn.sign_define("GitSignsChange",       { text = '', numhl= "GitSignsChange" })
    vim.fn.sign_define("GitSignsChangedelete", { text = '', numhl= "GitSignsChange" })
    vim.fn.sign_define("GitSignsDelete",       { text = '', numhl= "GitSignsDelete" })
    vim.fn.sign_define("GitSignsTopdelete",    { text = '', numhl= "GitSignsDelete" })
    vim.fn.sign_define("GitSignsUntracked",    { text = '', numhl= "GitSignsAdd" })
  end

  -- No Icons for error/warns or any diagnostics
  vim.fn.sign_define("DiagnosticSignError", { text = '', numhl= "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn",  { text = '', numhl= "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo",  { text = '', numhl= "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint",  { text = '', numhl= "DiagnosticSignHint" })
end

vim.api.nvim_create_autocmd("VimEnter", {
  command = "lua ClearSigns()"
})

---------------------------------------------------------------------------
-- Comment
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "folke/todo-comments.nvim",
  event = "BufRead",
  config = function()
    require("todo-comments").setup({
      signs = false
    })
  end
})

---------------------------------------------------------------------------
--  Treesitter
---------------------------------------------------------------------------
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.highlight.enabled = true
