local M = {}

table.insert(M, { "quarto-dev/quarto-vim",
   ft = {"quarto"},
   dependencies = {
      {"vim-pandoc/vim-pandoc-syntax"},
   },
})

return M
