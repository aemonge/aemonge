local M = {}

-- local chatgtp = require("settings.bots.chat-gpt")
-- table.insert(M, chatgtp)

-- local cmpcodex = require("settings.bots.cmp-codex")
-- table.insert(M, cmpcodex)

-- local cmp = require "settings.bots.cmp"
-- table.insert(M, cmp)

local coc = require("settings.bots.coc")
table.insert(M, coc)

-- local cmptabnine = require("settings.bots.tabnine")
-- table.insert(M, cmptabnine)

return M
