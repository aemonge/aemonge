--------------------------------------------------------------------------------------------------------------------------
--                                                    Code Analysis                                                      |
--------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------
-- Lint
---------------------------------------------------------------------------
require "lvim.lsp.null-ls.linters".setup {
  { command = "rubocop", filetypes = { "ruby" }}, -- , severity = 1 (error), 2 (warning), 3 (information), 4 (hint)
  { command = "eslint", filetypes = { "javascript", "typescript" }, },
  { command = "pylint", filetypes = { "python" }, },
}

---------------------------------------------------------------------------
-- Todos, Helpers and Tag-Search
---------------------------------------------------------------------------
table.insert(lvim.plugins, {
  "folke/trouble.nvim",
    cmd = "TroubleToggle",
})
lvim.keys.normal_mode["<C-q>"] = ":TroubleToggle <cr>"

---------------------------------------------------------------------------
-- lsp-zero.nvim
---------------------------------------------------------------------------
-- table.insert(lvim.plugins, { "VonHeikemen/lsp-zero.nvim",
--   dependencies = {
--     -- LSP Support
--     {'neovim/nvim-lspconfig'},
--     {'williamboman/mason.nvim'},
--     {'williamboman/mason-lspconfig.nvim'},

--     -- Autocompletion
--     {'hrsh7th/nvim-cmp'},
--     {'hrsh7th/cmp-buffer'},
--     {'hrsh7th/cmp-path'},
--     {'saadparwaiz1/cmp_luasnip'},
--     {'hrsh7th/cmp-nvim-lsp'},
--     {'hrsh7th/cmp-nvim-lua'},

--     -- Snippets
--     {'L3MON4D3/LuaSnip'},
--     {'rafamadriz/friendly-snippets'},
--   },
--   config = function()
--     local lsp = require('lsp-zero')
--     lsp.preset('recommended')
--     lsp.ensure_installed({
--       'html', 'cssls', 'tsserver', 'eslint',
--       'solargraph',
--       'pyright'
--     })
--     lsp.nvim_workspace()
--     lsp.setup()
--   end
-- })
