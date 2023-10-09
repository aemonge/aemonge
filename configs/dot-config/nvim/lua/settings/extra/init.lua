local M = {}

local dial = require("settings.extra.dial")
table.insert(M, dial)

local glow = require("settings.extra.glow")
table.insert(M, glow)

local ghost = require("settings.extra.ghost")
table.insert(M, ghost)

local swenv = require("settings.extra.swenv")
table.insert(M, swenv)

-- local venv = require("settings.extra.venv")
-- table.insert(M, venv)

table.insert(M, { "lewis6991/impatient.nvim" })

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

table.insert(M, {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
        require("persistence").setup({
            options = { "curdir", "tabpages", "winsize" },
        })
    end
})

table.insert(M, { "plasticboy/vim-markdown" })

return M
