local M = {}

require "settings.terminal.autocommands"
require "settings.terminal.terminal-functions"

local toggleterm = require "settings.terminal.toggleterm"  -- require "settings.terminal.mappings"
table.insert(M, toggleterm)

return M
