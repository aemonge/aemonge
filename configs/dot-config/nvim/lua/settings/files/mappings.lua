local M = {}

M.M = {
    t = { ":lua ClearTerm()<CR>", "Clear Term" },
    f = { ":let @+=fnamemodify(expand('%'), ':~:.')<CR>", "Yank file-path" },
    F = { ":let @+=fnamemodify(expand('%:t'), ':~:.')<CR>", "Yank file-name" },
    a = { "ggVGyg;", "Yank file contents" },
    p = { "ggVGpg;", "Replace file contents with clipboard" },
    c = { "ggVGdg;", "Clear file contents" },
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
