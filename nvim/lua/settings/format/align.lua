local M = {}

table.insert(M, {
    "junegunn/vim-easy-align",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
    }),
    config = function()
        local wk = require("which-key")

        wk.register({
            t = { "<Plug>(LiveEasyAlign)", "Align (<c-p> to accept)" },
        }, {
            mode    = "v",
            prefix  = "<leader>",
            buffer  = nil,
            silent  = true,
            noremap = true,
            nowait  = true,
        })
    end,
})

return M
