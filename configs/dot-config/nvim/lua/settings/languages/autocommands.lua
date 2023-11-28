vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  command = "set colorcolumn=88",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "javascript" },
  command = "set colorcolumn=120",
})
