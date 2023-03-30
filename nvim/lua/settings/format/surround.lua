local M = {}

table.insert(M, {
    "tpope/vim-surround",
    ft = require("file-types")({
        "markup",
        "languages",
    }),
})

return M
