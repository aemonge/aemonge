local M = {}

table.insert(M, {
    "gpanders/editorconfig.nvim",
    ft = require("file-types")({
        "markup",
        "languages",
        "frameworks",
    }),
})

table.insert(M, {
  "lukas-reineke/virt-column.nvim",
  opts = {} ,
})


local alignment = require("settings.format.align")
table.insert(M, alignment)

local comment = require("settings.format.comment")
table.insert(M, comment)

local autpair = require("settings.format.autopairs")
table.insert(M, autpair)

local surround = require("settings.format.surround")
table.insert(M, surround)

return M
