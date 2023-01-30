local M = {}

---------------------------------------------------------------------------
-- [neovim-remote](nvr): Close on Git Commit messages
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = {"gitrebase", "gitcommit", "diff"},
  command = "setlocal bufhidden=wipe"
})

t_mappings = require "settings.terminal.my-terminal"
n_mappings = require "settings.terminal.mappings"

local toggleterm = require "settings.terminal.toggleterm"
table.insert(M, toggleterm)

return M
