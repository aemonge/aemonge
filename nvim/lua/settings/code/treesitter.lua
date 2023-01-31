local M = {}

vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"

table.insert(M, { "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "andymass/vim-matchup",
    "nvim-treesitter/nvim-treesitter-context" ,
    "theHamsta/nvim-treesitter-pairs"
  },
  build = ":TSUpdate",
  config = function ()
    require'nvim-treesitter.configs'.setup {
      auto_install = true,
      context_commentstring = {
        enable = true
      }
    }
  end
})

return M
