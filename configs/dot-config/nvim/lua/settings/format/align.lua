local M = {}

table.insert(M, {
    "junegunn/vim-easy-align",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
    }),
    keys = {
        { '<leader>a', "<Plug>(EasyAlign)*",     { silent = true, noremap = true, nowait = true }, mode = "v", desc = "Align" },
        { '<leader>A', "<Plug>(LiveEasyAlign)*", { silent = true, noremap = true, nowait = true }, mode = "v", desc = "Live Align (<c-p> to accept)" },
    }
})

return M
