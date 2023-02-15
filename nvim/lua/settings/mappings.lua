local normal = {}
local visual = {}
local leader_normal = {}

-- Normal mappings
local go_to = require "settings.mappings.goto"
table.insert(normal, go_to)

-- Leader Mappings
local toggler = require "settings.mappings.toggler"
table.insert(leader_normal, toggler)

local current_file_ops = require "settings.mappings.current_file_ops"
table.insert(leader_normal, current_file_ops)

return {
  normal = normal,
  visual = visual,
  leader_normal = leader_normal,
}
