local M = {}

local cycle = require("settings.extra.cycle")
table.insert(M, cycle)

local scratch = require("settings.extra.scratch")
table.insert(M, scratch)

local grammar = require("settings.extra.grammar-guard")
table.insert(M, grammar)

local glow = require("settings.extra.glow")
table.insert(M, glow)

local ghost = require("settings.extra.ghost")
table.insert(M, ghost)

table.insert(M, { "tpope/vim-repeat" })

return M
