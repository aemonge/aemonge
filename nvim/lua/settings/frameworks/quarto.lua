local M = {}

table.insert(M, { 'quarto-dev/quarto-nvim',
  ft = { "quarto" },
  dependencies = {
    'jmbuhr/otter.nvim',
    'neovim/nvim-lspconfig'
  },
  config = function()
    require 'quarto'.setup {
      lspFeatures = {
        enabled = true,
        -- languages = { 'r', 'python', 'julia' },
        languages = { 'python' },
        diagnostics = {
          enabled = true,
          triggers = { "BufWrite" }
        },
        completion = {
          enabled = true
        }
      }
    }
  end
})

return M
