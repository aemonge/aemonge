local M = {}
local D = {}

table.insert(D, {
    "brymer-meneses/grammar-guard.nvim",
    event = "InsertEnter",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "versionControl",
    }),
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    build = function()
        require("grammar-guard").init()
    end,
    config = function()
        require("lspconfig").grammar_guard.setup({
            cmd = { "/home/aemonge/usr/bin/ltex-ls" }, -- https://github.com/valentjn/ltex-ls/releases/tag/15.2.0
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
        require("grammar-guard").init()
    end,
})

table.insert(M, {
    "vigoux/ltex-ls.nvim",
    ft = require("file-types")({
        "markup",
        "versionControl",
    }),
    config = function()
        require("ltex-ls").setup({
            use_spellfile = false,
            window_border = "rounded",
            filetypes = require("file-types")({
                "markup",
                "versionControl",
            }),
            settings = {
                ltex = {
                    enabled = { "latex", "tex", "bib", "markdown" },
                    language = "auto",
                    diagnosticSeverity = "information",
                    sentenceCacheSize = 2000,
                    additionalRules = {
                        enablePickyRules = true,
                        motherTongue = "es,en",
                    },
                },
            },
        })
    end,
})

return M
