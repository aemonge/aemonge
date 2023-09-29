local M = {}

table.insert(M, {
    "phaazon/hop.nvim",
    event = "BufRead",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
        "data",
        "versionControl",
    }),
    config = function()
        require("hop").setup()
    end,
})

return M
