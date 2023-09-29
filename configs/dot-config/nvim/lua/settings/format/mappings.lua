local M = {}


M.M = {
    g = {
        name = "Go to",
        a = { "<Plug>(EasyAlign)*", "Align" },
        A = { "<Plug>(LiveEasyAlign)*", "Live Align (<c-p> to accept)" },
    },

    ["<leader>"] = {
        ["/"] = { "<Plug>(comment_toggle_linewise_current)<cr>", "Comment" },
    }
}

M.O = {
    mode = { "v", "n" },
    prefix = nil,
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
