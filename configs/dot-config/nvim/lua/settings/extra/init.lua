local M = {}

local dial = require("settings.extra.dial")
table.insert(M, dial)

local ghost = require("settings.extra.ghost")
table.insert(M, ghost)

table.insert(M, { "lewis6991/impatient.nvim" })

table.insert(M, {
  "lambdalisue/suda.vim",
  config = function()
    vim.g.suda_smart_edit = 1
  end
})

table.insert(M, {
  "tpope/vim-repeat",
  ft = require("file-types")({
    "text",
    "markup",
    "languages",
    "frameworks",
    "data",
    "versionControl",
  }),
})

table.insert(M, {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  config = function()
    require("persistence").setup({
      options = { "curdir", "tabpages", "winsize" },
    })
  end
})

return M
