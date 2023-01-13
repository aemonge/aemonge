--------------------------------------------------------------------------------------------------------------------------
--                                                    Code History                                                       |
--------------------------------------------------------------------------------------------------------------------------
vim.opt.history = 1000     -- Increase the lines of history
vim.opt.undofile = true    -- Use a directory to save undos
vim.opt.undolevels = 10000 -- maximum number of changes that can be undone
vim.opt.undoreload = 10000 -- maximum number lines to save for undo on a buffer reload

---------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "tpope/vim-fugitive",
  cmd = {
    "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove",
    "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit"
  },
  ft = { "fugitive" }
})
