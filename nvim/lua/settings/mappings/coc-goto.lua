local M = {}

M.n = {
    d = { "<CMD>lua _G.goto_priority()<CR>", "Definition, type, implementation, references" },
    f = { "<CMD>lua _G.goto_file()<CR>", "File" },

    n = { "<Plug>(coc-diagnostic-next)", "Next Diagnostic" },
    p = { "<Plug>(coc-diagnostic-prev)", "Previous Diagnostic" },
}

M.nOpts = {
    mode = "n",
    name = "Go to ...",
    prefix = "g",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
