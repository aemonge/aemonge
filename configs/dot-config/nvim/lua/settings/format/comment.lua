local M = {}

table.insert(M, {
    "numToStr/Comment.nvim",
    ft = require("file-types")({
        "languages",
        "frameworks",
        "markup"
    }),
    config = function()
        require("Comment").setup({
            opleader = false,
            extra = false,
            stiky = true,
            mappings = false,
            pre_hook = nil,
            post_hook = nil,
        })

        require("which-key").register({
            ["/"] = { "<Plug>(comment_toggle_linewise_visual)<cr>", "Comment" },
        }, {
            mode = "v",
            prefix = "leader",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end,
})

return M
