local M = {}
local D = {}

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

table.insert(D, {
    'codota/tabnine-nvim',
    ft = require("file-types")({
        "languages",
        "frameworks",
    }),
    build = "./dl_binaries.sh",
    config = function()
        require('tabnine').setup({
            disable_auto_comment = true,
            accept_keymap = "<C-l>",
            dismiss_keymap = "<C-c>",
            debounce_ms = 300,
            suggestion_color = { gui = "#916690" },
            exclude_filetypes = { "TelescopePrompt" },
            plugins = {
                cmp = true
            }
        })
    end
})

return M
