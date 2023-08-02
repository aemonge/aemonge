local M = {}

table.insert(M, {
    "tpope/vim-surround",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
        "data",
        "versionControl",
    }),
})

return M
