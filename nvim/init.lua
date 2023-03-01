vim.keymap.set("", ",", "<Nop>", { silent = true, noremap = true, nowait = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require "settings.general"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require "settings.extra.smart-mappings"

my_mappings = require "settings.mappings"

local plugins = {}
local lazy_settings = require "settings.core.lazy"

local core = require "settings.core"
table.insert(plugins, core)

local visual = require "settings.visual"
table.insert(plugins, visual)

local terminal = require "settings.terminal"
table.insert(plugins, terminal)

local code = require "settings.code"
table.insert(plugins, code)

local bots = require "settings.bots"
table.insert(plugins, bots)

local lsp = require "settings.lsp"
table.insert(plugins, lsp)

local frameworks = require "settings.frameworks"
table.insert(plugins, frameworks)

-- local debbug = require "settings.debug"
-- table.insert(plugins, debbug)

local navigation = require "settings.navigation"
table.insert(plugins, navigation)

local search = require "settings.search"
table.insert(plugins, search)

local extra = require "settings.extra"
table.insert(plugins, extra)

require("lazy").setup(plugins, lazy_settings)
