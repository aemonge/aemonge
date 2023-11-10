local M = {}

M.M = {
    name = "File operations",
    f = { ":let @+=fnamemodify(expand('%'), ':~:.')<CR>", "Yank file-path" },
    F = { ":let @+=fnamemodify(expand('%:t'), ':~:.')<CR>", "Yank file-name" },
    a = { "ggVGyg;", "Yank file contents" },
    p = { "ggVGpg;", "Replace file contents with clipboard" },
    c = { "ggVGdg;", "Clear file contents" },
    r = { "<cmd>lua require('persistence').load()<cr>", "Restore local session" },
    R = { "<cmd>lua require('persistence').load({last = true})<cr>", "Restore last session" },
    n = { ":g/^ *$/d<cr>", "Remove empty lines" }
}

M.O = {
    mode = "n",
    prefix = "<leader>.",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
