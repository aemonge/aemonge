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

smart_maps = require "settings.extra.smart-mappings"

plugins = {}
lazy_settings = require "settings.core.lazy"

core = require "settings.core"
table.insert(plugins, core)

visual = require "settings.visual"
table.insert(plugins, visual)

terminal = require "settings.terminal"
table.insert(plugins, terminal)

code = require "settings.code"
table.insert(plugins, code)

navigation = require "settings.navigation"
table.insert(plugins, navigation)

extra = require "settings.extra"
table.insert(plugins, extra)

require("lazy").setup(plugins, lazy_settings)
