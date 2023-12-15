local M = {}

-- local chatgtp = require("settings.bots.chat-gpt")
-- table.insert(M, chatgtp)

local huggingface = require("settings.bots.huggingface-llm")
table.insert(M, huggingface)

local oatmeal = require("settings.bots.oatmeal")
table.insert(M, oatmeal)

-- local cmptabnine = require("settings.bots.tabnine")
-- table.insert(M, cmptabnine)

-- local neoai = require("settings.bots.neoai")
-- table.insert(M, neoai)

return M
