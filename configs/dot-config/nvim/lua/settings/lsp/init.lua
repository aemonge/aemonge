local M = {}

require("settings.lsp.helpers")

local ufo = require("settings.lsp.nvim-ufo")
table.insert(M, ufo)

-- https://github.com/creativenull/diagnosticls-configs-nvim/blob/main/supported-linters-and-formatters.md
table.insert(M, {
    "creativenull/diagnosticls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    -- config = function()
    -- local dlsconfig = require 'diagnosticls-configs'
    -- end
})

table.insert(M, {
    "neoclide/coc.nvim",
    branch = 'release',
    dependencies = { "ms-jpq/coq.artifacts", "ms-jpq/coq.thirdparty" },
    build = function()
        local extensions = require("settings.lsp.coc-extensions")
        for _, deps in pairs(extensions.list) do
            for _, dependency in ipairs(deps) do
                vim.cmd(":CocInstall " .. dependency)
            end
        end
    end,
    config = function()
        require("settings.lsp.mappings.coc-autocomplete")
        require("settings.lsp.mappings.coc-diagnostics")
        require("settings.lsp.mappings.coc-goto")
        require("settings.lsp.mappings.coc-lsp")
        require("settings.lsp.mappings.coc-func-object")
    end

})

return M
