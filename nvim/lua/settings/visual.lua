local M = {}

local theme = require "settings.visual.theme"
table.insert(M, theme)

local gitsigns = require "settings.visual.gitsigns"
table.insert(M, gitsigns)

local bufferline = require "settings.visual.bufferline"
table.insert(M, bufferline)

local lualine = require "settings.visual.lualine"
table.insert(M, lualine)

return M
