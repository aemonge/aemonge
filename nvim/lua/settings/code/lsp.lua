-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/advance-usage.md
local M = {}

table.insert(M, { "williamboman/mason.nvim",
  config = function ()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
      }
    })
  end
})

table.insert(M, { 'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
  },
  config = function()
    local lsp = require('lsp-zero')
    lsp.set_preferences({
      suggest_lsp_servers = true,
      setup_servers_on_start = true,
      configure_diagnostics = true,
      cmp_capabilities = true,
      manage_nvim_cmp = false,
      call_servers = 'local',
      sign_icons = false,
      set_lsp_keymaps = {
        omit = {
          '<C-k>', '<Ctrl-k>'
        }
      },
    })

    lsp.setup()

    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      update_in_insert = false,
      underline = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = 'minimal',
        border = 'rounded',
        source = 'always'
      },
    })

    function ClearSigns()
      vim.fn.sign_define("DiagnosticSignError", { text = '', numhl= "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",  { text = '', numhl= "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo",  { text = '', numhl= "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint",  { text = '', numhl= "DiagnosticSignHint" })
    end

    ClearSigns()
  end
})

return M
