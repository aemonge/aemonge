table.insert(plugins, { "nvim-treesitter/nvim-treesitter",
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
    }
    require'nvim-treesitter.configs'.setup {
      context_commentstring = {
        enable = true
      }
    }
  end
})
