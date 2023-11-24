local M = {}

M.M = {
    ["lb"] = { ":Gitsigns blame_line<cr>", "Git blame" },
    n = { ":Telescope notify<cr>", "Notifications" }
}

M.O = {

    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
