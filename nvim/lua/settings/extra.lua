local M = {}

-- local cycle = require("settings.extra.cycle")
-- table.insert(M, cycle)

local dial = require("settings.extra.dial")
table.insert(M, dial)

-- local distant = require("settings.extra.distant")
-- table.insert(M, distant)

-- local scratch = require("settings.extra.scratch")
-- table.insert(M, scratch)

-- local grammar = require("settings.extra.grammar-guard")
-- table.insert(M, grammar)

local glow = require("settings.extra.glow")
table.insert(M, glow)

local ghost = require("settings.extra.ghost")
table.insert(M, ghost)

local notify = require("settings.extra.notify")
table.insert(M, notify)

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

return M
