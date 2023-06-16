local M = {}

local theme = require "settings.visual.theme"
table.insert(M, theme)

local dressing = require "settings.visual.dressing"
table.insert(M, dressing)

local gitsigns = require "settings.visual.gitsigns"
table.insert(M, gitsigns)

local bufferline = require "settings.visual.bufferline"
table.insert(M, bufferline)

local tint = require "settings.visual.tint"
table.insert(M, tint)

-- local limelight = require "settings.visual.limelight"
-- table.insert(M, limelight)

local lualine = require "settings.visual.lualine"
table.insert(M, lualine)

local overlength = require "settings.visual.overlength"
table.insert(M, overlength)

return M
