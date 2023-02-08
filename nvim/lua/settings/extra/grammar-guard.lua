local M = {}

table.insert(M, { "brymer-meneses/grammar-guard.nvim",
  dependencies = {
    "neovim/nvim-lspconfig"
  },
  build = function ()
    require("grammar-guard").init()
  end,
  config = function ()
    require("lspconfig").grammar_guard.setup({
      cmd = { '~/u/bin/ltex-ls' }, -- https://github.com/valentjn/ltex-ls/releases/tag/15.2.0
      settings = {
        ltex = {
          enabled = { "latex", "tex", "bib", "markdown", "html", "" },
          language = "en,es",
          diagnosticSeverity = "information",
          setenceCacheSize = 2000,
          additionalRules = {
            enablePickyRules = true,
            motherTongue = "es,en",
          },
          trace = { server = "verbose" },
          dictionary = {},
          disabledRules = {},
          hiddenFalsePositives = {},
        },
      },
    })
  end
})

return M
