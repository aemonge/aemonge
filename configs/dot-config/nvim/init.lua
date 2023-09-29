vim.keymap.set("", ",", "<Nop>", { silent = true, noremap = true, nowait = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- DEBUG
-- vim.opt.cmdheight = 2
-- vim.cmd[[set shortmess-=F]]
-- vim.opt.verbose = 3
-- vim.cmd[[set verbosefile=~/nvim.log]]

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

-- Start Configuration and Stuff

require "settings.general"
local conf = require("settings.core")
local helpers = require("helpers")
local lazy = require "lazy"
local plugins = {}

table.insert(plugins, helpers.require_configs())
table.insert(plugins, {
    "folke/which-key.nvim",
    priority = 100,
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 180
    end,
    config = function()
        local wk = require("which-key")
        wk.setup(conf.whichKey)
        helpers.require_mappings(wk)
    end,
})

lazy.setup(plugins, conf.lazy)
helpers.require_autocommands()
