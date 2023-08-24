local M = {}

M.i = {
    K = { "<CMD>lua _G.show_docs()<CR>", "Show Documentation" }
}

M.iOpts = {
    mode = "n",
    prefix = nil,
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

M.n = {
    d = { "<CMD>lua _G.show_diagnostic_line()<CR>", "Diagnostic hover" },
}

M.nOpts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
