local M = {}

-- local dap = require("settings.debug.dap")
-- table.insert(M, dap)

local debugprint = require("settings.debug.debugprint")
table.insert(M, debugprint)

local neotest = require("settings.debug.neotest")
table.insert(M, neotest)

return M
