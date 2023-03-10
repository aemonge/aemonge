local M = {}

---------------------------------------------------------------------------
-- Make the past keep the clipboard, and don't replace it
---------------------------------------------------------------------------
-- vim.keymap.set("v", "p", '"_dP', { silent = true, noremap = true, nowait = true })

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
