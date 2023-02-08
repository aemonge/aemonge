local M = {}

require "settings.terminal.autocommands"
require "settings.terminal.functions"

-- This plugin allows you to quickly delete multiple buffers based on the conditions provided.
table.insert(M, { "kazhala/close-buffers.nvim" })

local toggleterm = require "settings.terminal.toggleterm"  -- require "settings.terminal.mappings"
table.insert(M, toggleterm)

return M
