local M = {}
M.M = {
    p = { [[:Telescope projects<CR>]], "Projects" }
}

M.O = {
    mode = { "n" },
    prefix = "<leader>t",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
