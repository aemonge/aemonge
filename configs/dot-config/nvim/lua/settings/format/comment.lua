local M = {}

table.insert(M, {
    "numToStr/Comment.nvim",
    ft = require("file-types")({
        "languages",
        "frameworks",
        "markup"
    }),
    config = function()
        require("Comment").setup({
            opleader = false,
            extra = false,
            mappings = false,
            pre_hook = nil,
            post_hook = nil,
        })
    end,
})

return M
