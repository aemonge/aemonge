local M = {}

local theme = require "settings.visual.theme"
table.insert(M, theme)

local dressing = require "settings.visual.dressing"
table.insert(M, dressing)

local notify = require("settings.visual.notify")
table.insert(M, notify)

local gitsigns = require "settings.visual.gitsigns"
table.insert(M, gitsigns)

local bufferline = require "settings.visual.bufferline"
table.insert(M, bufferline)

local noice = require "settings.visual.noice"
table.insert(M, noice)

local tint = require "settings.visual.tint"
table.insert(M, tint)

local twilight = require "settings.visual.twilight"
table.insert(M, twilight)

table.insert(M, {
    "ChristianChiarulli/neovim-codicons"
})

local lualine = require "settings.visual.lualine"
table.insert(M, lualine)

return M
