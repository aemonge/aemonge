local M = {}

require("settings.coc.helpers")

local ufo = require("settings.coc.nvim-ufo")
table.insert(M, ufo)

table.insert(M, {
    "neoclide/coc.nvim",
    branch = 'release',
    dependencies = { "ms-jpq/coq.artifacts", "ms-jpq/coq.thirdparty" },
    build = function()
        local extensions = require("settings.coc.extensions")
        for _, deps in pairs(extensions.list) do
            for _, dependency in ipairs(deps) do
                vim.cmd(":CocInstall " .. dependency)
            end
        end
    end,
    config = function()
        local wk = require("which-key")

        -- Autocommands
        require("settings.autocommands.coc")

        -- Mappings
        local cocAutocomplete = require("settings.mappings.coc-autocomplete")
        wk.register(cocAutocomplete.i, cocAutocomplete.iOpts)
        wk.register(cocAutocomplete.i_exp, cocAutocomplete.iOpts_exp)

        local cocDiagnostics = require("settings.mappings.coc-diagnostics")
        wk.register(cocDiagnostics.i, cocDiagnostics.iOpts)
        wk.register(cocDiagnostics.n, cocDiagnostics.nOpts)

        local cocGoto = require("settings.mappings.coc-goto")
        wk.register(cocGoto.n, cocGoto.nOpts)

        -- LSP and COC actions
        local cocLsp = require("settings.mappings.coc-lsp")
        wk.register(cocLsp.n, cocLsp.nOpts)
        wk.register(cocLsp.v, cocLsp.vOpts)


        -- Map function and class text objects.
        --   Requires 'textDocument.documentSymbol' support from the language server
        local cocObj = require("settings.mappings.coc-func-object")
        wk.register(cocObj.map, cocObj.opts)
    end

})

return M
