local M = {}

local dial = require("settings.extra.dial")
table.insert(M, dial)

-- local ghost = require("settings.extra.ghost")
-- table.insert(M, ghost)

-- table.insert(M, {
--     -- "cosminadrianpopescu/vim-tail",
--     "krischik/vim-tail",
--     keys = {
--         { '<leader>.o', "<cmd>TailStart<CR>", { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Tail current file" },
--         { '<leader>.O', "<cmd>TailStop<CR>",  { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Stop tailing" },
--     }
-- })

table.insert(M, { "lewis6991/impatient.nvim" })

table.insert(M, {
    "lambdalisue/suda.vim",
    config = function()
        vim.g.suda_smart_edit = 1
    end
})

table.insert(M, {
    "tpope/vim-repeat",
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
