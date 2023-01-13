--------------------------------------------------------------------------------------------------------------------------
--                                              Quick Smart Mappings                                                     |
--------------------------------------------------------------------------------------------------------------------------
lvim.builtin.which_key.mappings["h"] = nil

---------------------------------------------------------------------------
--  Copy
---------------------------------------------------------------------------
lvim.builtin.which_key.mappings["y"] = {
  name = "+Yank",
  F = { ":let @+=fnamemodify(expand('%'), ':~:.')<CR>", "Yank file-path" },
  f = { ":let @+=fnamemodify(expand('%:t'), ':~:.')<CR>", "Yank file-name" },
  a = { "ggVGyg;", "Yank file-contents" }
}

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

---------------------------------------------------------------------------
-- My Own Toggler for settings
---------------------------------------------------------------------------
lvim.builtin.which_key.mappings["t"] = {
  name = "Toggler",
  e = {":setlocal foldenable!<cr>", "Fold"},
  w = {":setlocal wrap!<cr>", "Wrap"},
  t = {":TroubleToggle document_diagnostics<cr>", "Trouble diagnostics"},
  p = {":TodoLocList<cr>", "Todo location list"},
  h = {":set nohlsearch!<cr>", "Search highlight"},
  l = {":Limelight!!<cr>", "Limelight"},
  u = {"<cmd>Telescope undo<cr>", "Telescope Undo"}
}
