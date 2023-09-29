local M = {}

table.insert(M, {
    "junegunn/vim-easy-align",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
    }),
})

return M
