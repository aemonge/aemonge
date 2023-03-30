local M = {}

table.insert(M, {
    "alpha2phi/cmp-openai-codex",
    ft = require("file-types")({
        "markup",
        "languages",
        "frameworks",
    }),
    event = "InsertEnter",
    dependencies = "hrsh7th/nvim-cmp",
})

return M
