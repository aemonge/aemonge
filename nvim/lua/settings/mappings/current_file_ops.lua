local M = {}

table.insert(M, {
  y = {
    name = "File operations",
    F = { ":let @+=fnamemodify(expand('%'), ':~:.')<CR>", "Yank file-path" },
    f = { ":let @+=fnamemodify(expand('%:t'), ':~:.')<CR>", "Yank file-name" },
    a = { "ggVGyg;", "Yank file contents" },
    p = { "ggVGpg;", "Replace file contents with clipboard" },
    c = { "ggVGdg;", "Clear file contents" }
  },
})

return M
