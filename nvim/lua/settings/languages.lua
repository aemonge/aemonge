local M = {}

local nullls = require("settings.languages.null-ls")
table.insert(M, nullls)

local treesitter = require "settings.languages.treesitter"
table.insert(M, treesitter)

local swenv = require "settings.languages.swenv"
table.insert(M, swenv)

return M
