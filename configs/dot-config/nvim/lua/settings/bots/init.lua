local M = {}

-- local chatgtp = require("settings.bots.chat-gpt")
-- table.insert(M, chatgtp)

local cmptabnine = require("settings.bots.tabnine")
table.insert(M, cmptabnine)

-- local neoai = require("settings.bots.neoai")
-- table.insert(M, neoai)

return M
