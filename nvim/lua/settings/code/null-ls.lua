local M = {}

table.insert(M, { "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-null-ls").setup({
      automatic_installation = true,
      automatic_setup = true,
    })
    require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.
  end,
})

return M
