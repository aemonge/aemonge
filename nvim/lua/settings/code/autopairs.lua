local M = {}

table.insert(M, { "windwp/nvim-autopairs",
    config = function() 
      require("nvim-autopairs").setup {} 
    end
})

return M
