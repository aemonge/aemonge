local M = {}

table.insert(M, {
    "junegunn/vim-easy-align",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
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
            ["/"] = { "<Plug>(comment_toggle_linewise_current)<cr>", "Comment" },
        }, {
            mode = "n",
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end,
})

return M
