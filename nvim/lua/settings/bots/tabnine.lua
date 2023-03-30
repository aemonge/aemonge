local M = {}

table.insert(M, {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    ft = require("file-types")({
        "languages",
        "frameworks",
    }),
    config = function()
        require("cmp_tabnine.config"):setup({
            max_lines = 1000,
            max_num_results = 20,
            sort = true,
            run_on_every_keystroke = true,
            snippet_placeholder = "...",
            show_prediction_strength = true,
        })
    end,
})

return M
