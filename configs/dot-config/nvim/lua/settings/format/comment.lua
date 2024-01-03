local M = {}

table.insert(M, {
    "numToStr/Comment.nvim",
    ft = require("file-types")({
        "languages",
        "frameworks",
        "markup"
    }),
    opts = {
        opleader = false,
        extra = false,
        stiky = true,
        mappings = false,
        pre_hook = nil,
        post_hook = nil,
    },
    keys = {
        { '<leader>/', '<Plug>(comment_toggle_linewise_current)<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "  Comment" },
        { '<leader>/', '<Plug>(comment_toggle_linewise_visual)<CR>', { silent = true, noremap = true, nowait = true }, mode = "v", desc = "  Comment" },
    }
})

return M
