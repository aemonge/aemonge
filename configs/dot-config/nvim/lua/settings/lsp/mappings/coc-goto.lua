local wk = require("which-key")

wk.register({
    d = { "<CMD>lua _G.goto_priority()<CR>", "Definition, type, implementation, references" },
    n = { "<Plug>(coc-diagnostic-next)", "Next Diagnostic" },
    p = { "<Plug>(coc-diagnostic-prev)", "Previous Diagnostic" },
}, {
    mode = "n",
    name = "Go to",
    prefix = "g",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})