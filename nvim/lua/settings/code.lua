local M = {}

table.insert(M, { "RRethy/nvim-align" })
table.insert(M, { "gpanders/editorconfig.nvim" })

local cmp = require "settings.code.cmp"
table.insert(M, cmp)

local treesitter = require "settings.code.treesitter"
table.insert(M, treesitter)

local comment = require "settings.code.comment"
table.insert(M, comment)

local autpair = require "settings.code.autopairs"
table.insert(M, autpair)

local swenv = require "settings.code.swenv"
table.insert(M, swenv)

local surround = require "settings.code.surround"
table.insert(M, surround)

return M
