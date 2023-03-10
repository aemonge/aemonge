local M = {}

table.insert(M, { "phaazon/hop.nvim",
  -- event = "BufRead",
  config = function()
    require("hop").setup()
    require "which-key".register({
      s = { ":HopChar2<cr>", "Hop to first two chars"},
      S = { ":HopPattern<cr>", "Hop to patter" }
    }, { prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true})
  end,
})

return M
