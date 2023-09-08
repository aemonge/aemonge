vim.keymap.set("", ",", "<Nop>", { silent = true, noremap = true, nowait = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- DEBUG
-- vim.opt.cmdheight = 2
-- vim.cmd[[set shortmess-=F]]
-- vim.opt.verbose = 3
-- vim.cmd[[set verbosefile=~/nvim.log]]

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

local plugins = {}
local lazy_settings = require "settings.core.lazy"

local core = require "settings.core"
table.insert(plugins, core)

local visual = require "settings.visual"
table.insert(plugins, visual)

local terminal = require "settings.terminal"
table.insert(plugins, terminal)

local format = require "settings.format"
table.insert(plugins, format)

local bots = require "settings.bots"
table.insert(plugins, bots)

local coc = require "settings.coc"
table.insert(plugins, coc)

local dap = require("settings.nvim-dap-ui")
table.insert(plugins, dap)

local navigation = require "settings.navigation"
table.insert(plugins, navigation)

local search = require "settings.search"
table.insert(plugins, search)

local extra = require "settings.extra"
table.insert(plugins, extra)

require "settings.autocommands"

require("lazy").setup(plugins, lazy_settings)
