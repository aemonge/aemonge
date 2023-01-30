local M = {}

table.insert(M, { "numToStr/Comment.nvim",
  config = function()
    local wk = require("which-key")
    require('Comment').setup({
      opleader = false,
      extra = false,
      mappings = false,
      pre_hook = nil,
      post_hook = nil,
    })

    wk.register({
      ['/'] = { "<Plug>(comment_toggle_linewise_current)<cr>", "Comment" }
    }, { mode = "n", prefix = "<leader>", buffer = nil, 
      silent = true, noremap = true, nowait = true, 
    })
    wk.register({
      ['/'] = { "<Plug>(comment_toggle_linewise_visual)<cr>", "Comment" }
    }, { mode = "v", prefix = "<leader>", buffer = nil, 
      silent = true, noremap = true, nowait = true, 
    })
  end
})

return M
