local M = {}

table.insert(M, {
    "lcheylus/overlength.nvim",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
        "data",
        "versionControl",
    }),
    config = function()
        require("overlength").setup({
            bg = "#692f2c",
            textwidth_mode = 1,
            default_overlength = 72, -- PEP8 way, get used to it !
            grace_length = 5,
            disable_ft = {
                "",
                "terminal",
                "qf",
                "help",
                "man",
                "scratch",
                "packer",
                "NvimTree",
                "Telescope",
                "WhichKey",
                "html",
                "markdown",
                "text",
            },
        })
    end,
})
-- asdf asd fa sdf asd fa sdf asd fas df asd f asdf as df asd f asdf as df asdf as df asdf as df asdf asdf asdf

return M
