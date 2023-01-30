local M = {}

table.insert(M, { "RRethy/nvim-align" })
table.insert(M, { "gpanders/editorconfig.nvim" })

local cycle = require("settings.extra.cycle")
table.insert(M, cycle)

local scratch = require("settings.extra.scratch")
table.insert(M, scratch)

local glow = require("settings.extra.glow")
table.insert(M, glow)

local ghost = require("settings.extra.ghost")
table.insert(M, ghost)

return M
