local M = { "subnut/nvim-ghost.nvim",
  lazy = true,
  build = ":call nvim_ghost#installer#install()"
}

return M
