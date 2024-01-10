local M = {}

table.insert(M, {
    "phaazon/hop.nvim",
    event = "BufRead",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
        "data",
        "versionControl",
    }),
    config = function()
        require("hop").setup()
    end,
    keys = {
        { 's',  ':HopWordAC<cr>',  { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Hop to pattern" },
        { 'S',  ':HopWordBC<cr>',  { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Hop to line" },
        { 'g/', ':HopPattern<cr>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Hop to pattern" },
    }
})

return M
