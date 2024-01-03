local wk = require("which-key")

wk.register({
    K = { "<CMD>lua _G.show_docs()<CR>", "Show Documentation" }
}, {
    mode = "n",
    prefix = nil,
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})

wk.register({
    d = { "<CMD>lua _G.show_diagnostic_line()<CR>", "  Diagnostic hover" },
    g = { ":Gitsigns blame_line<cr>", "  Git blame" },
}, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})
