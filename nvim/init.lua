require "settings.options"

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

maps_opts = {
  silent = true,
  noremap = true,
  nowait = true,
}
plugins = {}

require "settings.theme"
require "settings.cmp"
require "settings.lsp"
require "settings.telescope"
require "settings.treesitter"
require "settings.autopairs"
require "settings.comment"
require "settings.gitsigns"
-- require "settings.nvim-tree" -- Start to slow down things
require "settings.bufferline"

require("lazy").setup(plugins)
