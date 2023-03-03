local M = {}

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = "*.qmd",
  command = 'set filetype=markdown'
})

-- local pyLsp = require "settings.frameworks.pylsp"
-- table.insert(M, pyLsp)

-- local otter = require "settings.frameworks.otter"
-- table.insert(M, otter)

-- local quarto = require("settings.frameworks.quarto")
-- table.insert(M, quarto)

return M
