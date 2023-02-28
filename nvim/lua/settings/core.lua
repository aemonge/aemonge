local M = {}

local mason = require "settings.core.mason"
table.insert(M, mason)

local whichkey = require "settings.core.which-key"
table.insert(M, whichkey)

local project = require "settings.core.project"
table.insert(M, project)

return M
