local M = {}

table.insert(M, {
    "sa-mendez/tail.nvim",
    event = "BufRead",
    after = "nvim-notify",
    config = function()
        require("tail_nvim").setup {
            smart_tail = false,
            -- notifier = require "notify",
        }
    end
})


return M
