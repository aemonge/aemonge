local M = {}

local cmp = require "settings.code.cmp"
table.insert(M, cmp)

local lsp = require "settings.code.lsp"
table.insert(M, lsp)

local treesitter = require "settings.code.treesitter"
table.insert(M, treesitter)

local comment = require "settings.code.comment"
table.insert(M, comment)

local autpair = require "settings.code.autopairs"
table.insert(M, autpair)

local swenv = require "settings.code.swenv"
table.insert(M, swenv)

return M
