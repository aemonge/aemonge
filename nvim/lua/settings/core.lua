local M = {}

local whichkey = require "settings.core.which-key"
table.insert(M, whichkey)

local project = require "settings.core.project"
table.insert(M, project)

return M
