local M = {}

table.insert(M, {
    "lcheylus/overlength.nvim",
    ft = require("file-types")({
        "markup",
        "languages",
        "frameworks",
    }),
    config = function()
        local disable_ft = require("file-types")({
            "text",
            "data",
            "versionControl",
            "plugings",
        })
        table.insert(disable_ft, "")
        table.insert(disable_ft, "terminal")
        require("overlength").setup({
            bg = "#692f2c",
            textwidth_mode = 1,
            default_overlength = 80, -- PEP8 way, get used to it !
            grace_length = 8, -- Black tolerates 88
            disable_ft = disable_ft,
        })
    end,
})
-- asdf asd fa sdf asd fa sdf asd fas df asd f asdf as df asd f asdf as df asdf as df asdf as df asdf asdf asdf

return M
