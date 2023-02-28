local M = {}

local camelcase = require "settings.navigation.camelcase" -- require "settings.navigation.mappings"
table.insert(M, camelcase)

local hop = require "settings.navigation.hop"
table.insert(M, hop)

local nvimtree = require "settings.navigation.nvim-tree"
table.insert(M, nvimtree)

return M
