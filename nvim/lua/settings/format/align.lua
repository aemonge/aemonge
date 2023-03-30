local M = {}

table.insert(M, {
    "RRethy/nvim-align",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
    }),
    config = function()
        local wk = require("which-key")

        wk.register({
            t = { ":Align ", "Align" },
        }, {
            mode = "v",
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end,
})

return M
