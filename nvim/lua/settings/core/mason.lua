local M = {}

table.insert(M, {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
      pip = {
        upgrade_pip = true,
      }
    })
  end
})

return M
