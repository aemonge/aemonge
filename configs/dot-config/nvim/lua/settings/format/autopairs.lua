local M = {}

table.insert(M, {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    ft = require("file-types")({
        "markup",
        "languages",
        "frameworks",
    }),
})

return M
