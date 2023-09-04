local M = {}

local dial = require("settings.extra.dial")
table.insert(M, dial)

local glow = require("settings.extra.glow")
table.insert(M, glow)

local ghost = require("settings.extra.ghost")
table.insert(M, ghost)

local notify = require("settings.extra.notify")
table.insert(M, notify)

local dap = require("settings.extra.nvim-dap-ui")
table.insert(M, dap)

local tail = require("settings.extra.tail")
table.insert(M, tail)
vim.cmd [[
 augroup filetypedetect
     au! BufRead,BufNewFile *.buffer setfiletype buffermd
 augroup END
]]

table.insert(M, { "lewis6991/impatient.nvim" })

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
  "plasticboy/vim-markdown"
})

return M
