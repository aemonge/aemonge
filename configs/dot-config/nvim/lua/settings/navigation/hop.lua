local M = {}

table.insert(M, {
    "phaazon/hop.nvim",
    event = "BufRead",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
        "data",
        "versionControl",
    }),
    config = function()
        require("hop").setup()
        require("which-key").register(
            {
                S = { ":HopVertical<cr>", "Hop to line" },
                s = { ":HopWordCurrentLine<cr>", "Hop to pattern" },
                ['g/'] = { ":HopPattern<cr>", "Hop to pattern" },
            },
            {
                prefix = nil,
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            }
        )
    end,
})

return M
