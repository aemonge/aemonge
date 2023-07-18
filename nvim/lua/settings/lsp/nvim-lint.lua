local M = {}

table.insert(M, {
    "mfussenegger/nvim-lint",
    ft = require("file-types")({
        "languages",
        "frameworks",
    }),
    config = function()
        require('lint').linters_by_ft = {
          markdown = {'vale'},
            python = {"mypy", "flake8", } ,
            vim = {"vint"},
        }
    end
})

return M
