local M = {}

table.insert(M, {
  'HallerPatrick/py_lsp.nvim',
  ft = {"quarto", "python"},
  config = function()
    require("py_lsp").setup({
      -- language_server = "jedi_language_server",
      source_strategies = { "default", "poetry", "conda", "system" },
    })
    require "which-key".register({
      l = {
        p = { ":PyLspReload<cr>", "Reload LSP Python" }
      }
    }, { prefix = '<leader>', buffer = nil, silent = true, noremap = true, nowait = true })
  end
})

return M
