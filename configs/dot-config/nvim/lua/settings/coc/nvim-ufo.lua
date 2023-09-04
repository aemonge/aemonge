local M = {}

table.insert(M, {
  "kevinhwang91/nvim-ufo",
  event = "BufRead",
  dependencies = {
    "kevinhwang91/promise-async",
    "neoclide/coc.nvim"
  },
  ft = require("file-types")({
    "markup",
    "languages",
    "frameworks",
  }),
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
    },
    {
      "zr",
      function()
        require("ufo").openFoldsExceptKinds()
      end,
    },
    {
      "zm",
      function()
        require("ufo").closeFoldsWith()
      end,
    },
  },
  build = "yarn install --frozen-lockfile",
  config = function()
    -- @SEE: https://github.com/kevinhwang91/nvim-ufo
    require('ufo').setup()
  end,
})

return M
