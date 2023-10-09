local M = {}
-- https://github.com/linux-cultist/venv-selector.nvim
table.insert(M, {
  "AckslD/swenv.nvim",
  config = function()
    require("swenv").setup({
      venvs_path = vim.fn.expand('~/.conda/envs')
    })
  end
})

return M
