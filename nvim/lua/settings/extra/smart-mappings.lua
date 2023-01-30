local M = {}

---------------------------------------------------------------------------
-- Make the past keep the clipboard, and don't replace it
---------------------------------------------------------------------------
vim.keymap.set("v", "p", '"_dP', { silent = true, noremap = true, nowait = true })

---------------------------------------------------------------------------
--  Copy and Toggler
---------------------------------------------------------------------------
table.insert(M, {
  y = {
    name = "File operations",
    F = { ":let @+=fnamemodify(expand('%'), ':~:.')<CR>", "Yank file-path" },
    f = { ":let @+=fnamemodify(expand('%:t'), ':~:.')<CR>", "Yank file-name" },
    a = { "ggVGyg;", "Yank file contents" },
    p = { "ggVGpg;", "Replace file contents with clipboard" },
    c = { "ggVGdg;", "Clear file contents" }
  },
  t = {
    name = "Toggler",
    e = {":setlocal foldenable!<cr>", "Fold"},
    w = {":setlocal wrap!<cr>", "Wrap"},
    f = {":lua vim.lsp.buf.format()<cr>", "Format with lsp"},
    -- t = {":TroubleToggle document_diagnostics<cr>", "Trouble diagnostics"},
    -- p = {":TodoLocList<cr>", "Todo location list"},
    h = {":set nohlsearch!<cr>", "Search highlight"},
    -- l = {":Limelight!!<cr>", "Limelight"},
  }
})

---------------------------------------------------------------------------
-- Strip all trailing white-space in the current file and a maximum
--       of two line breaks
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  callback = function()
    vim.cmd [[
      retab
      silent! %s/\s\+$//e
      silent! %s/^\n\{3,}/\r\r/e
    ]]
  end
})

return M
