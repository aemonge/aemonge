local M = {}

table.insert(M, {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    ft = require("file-types")({
        "markup",
        "languages",
        "frameworks",
    }),
    config = function()
        require("nvim-autopairs").setup({})
    end,
})

return M
