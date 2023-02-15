local M = {}

table.insert(M, {
  g = {
    name = "Go to:",
    d = { vim.lsp.buf.definition, "Definition"},
    D = { vim.lsp.buf.declaration, "Declaration"},
    i = { vim.lsp.buf.implementation, "Implementation"},
    r = { vim.lsp.buf.references, "References"},
    F = { vim.lsp.buf.declaration, "File"},
    l = { vim.diagnostic.open_float, "Diagnostics (line)" }
  }
})

return M
