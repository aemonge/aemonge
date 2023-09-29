local M = {}

function M.require_configs()
    local _plugins = {}
    local conf_dir = vim.fn.stdpath('config')
    local files = vim.fn.globpath(conf_dir .. "/lua/settings/", "**/init.lua", 0, 1)
    for _, file in ipairs(files) do
        local module_path = file:gsub(conf_dir .. "/lua/", ""):gsub("%.lua$", "")
        local N = require(module_path)
        table.insert(_plugins, N)
    end
    return _plugins
end

function M.require_autocommands()
    local conf_dir = vim.fn.stdpath('config')
    local files = vim.fn.globpath(conf_dir .. "/lua/", "**/autocommands.lua", 0, 1)
    for _, file in ipairs(files) do
        local module_path = file:gsub(conf_dir .. "/lua/", ""):gsub("%.lua$", "")
        require(module_path)
    end
end

function M.require_mappings(wk)
    local conf_dir = vim.fn.stdpath('config')
    local files = vim.fn.globpath(conf_dir .. "/lua/settings/", "**/mappings.lua", 0, 1)
    for _, file in ipairs(files) do
        local module_path = file:gsub(conf_dir .. "/lua/", ""):gsub("%.lua$", "")
        local m = require(module_path)
        wk.register(m.M, m.O)
    end
end

return M
