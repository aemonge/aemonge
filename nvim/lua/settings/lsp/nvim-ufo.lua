local M = {}

table.insert(M, {
  "kevinhwang91/nvim-ufo",
  event = "BufRead",
  dependencies = { "kevinhwang91/promise-async" },
  keys = {
    { "zR", function() require("ufo").openAllFolds() end },
    { "zM", function() require("ufo").closeAllFolds() end },
    { "zr", function() require("ufo").openFoldsExceptKinds() end },
    { "zm", function() require("ufo").closeFoldsWith() end }
  },
  config = function()
    -- Option 2: nvim lsp as LSP client
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    local language_servers = require("lspconfig").util.available_servers()
    for _, ls in ipairs(language_servers) do
      require('lspconfig')[ls].setup({
        capabilities = capabilities
      })
    end
    require('ufo').setup({})
    --

    -- Option 3: treesitter as a main provider instead
    -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
    -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
    -- require('ufo').setup({
    --   provider_selector = function(bufnr, filetype, buftype)
    --     return { 'treesitter', 'indent' }
    --   end
    -- })

    -- vim.api.nvim_create_autocmd({ "BufNew" }, {
    --   callback = require('ufo').closeAllFolds
    -- })
  end
})

return M
