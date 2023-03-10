-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/advance-usage.md
local M = {}

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
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        code = true,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = function(diagnostic)
          local code = diagnostic.code

          if code == nil then
            code = ''
          else
            code = '('.. code ..') '
          end

          if diagnostic.severity == vim.diagnostic.severity.ERROR then
            return '  ' .. code
          elseif diagnostic.severity == vim.diagnostic.severity.WARN then
            return '  ' .. code
          elseif diagnostic.severity == vim.diagnostic.severity.INFO then
            return '  ' .. code
          elseif diagnostic.severity == vim.diagnostic.severity.HINT then
            return ' 󱧢 ' .. code
          else
            return code
          end
        end
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

-- { 'rmagatti/goto-preview', }

return M
