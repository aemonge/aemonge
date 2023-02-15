local M = {}

local cycle = require("settings.extra.cycle")
table.insert(M, cycle)

local scratch = require("settings.extra.scratch")
table.insert(M, scratch)

local ufo = require("settings.extra.nvim-ufo")
table.insert(M, ufo)

-- local grammar = require("settings.extra.grammar-guard")
-- table.insert(M, grammar)

local glow = require("settings.extra.glow")
table.insert(M, glow)

local ghost = require("settings.extra.ghost")
table.insert(M, ghost)

table.insert(M, { "tpope/vim-repeat" })

table.insert(M, { "rcarriga/nvim-notify",
  priority = 99999,
  config = function ()
    require "notify".setup({
      background_colour = "#000000",
      max_width = 70,
      stages = "slide",
      timeout = 2000,
    })
    vim.notify = require("notify")
  end
})

return M
