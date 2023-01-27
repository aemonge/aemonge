table.insert(plugins, { "numToStr/Comment.nvim",
  config = function()
    require('Comment').setup({
      opleader = false,
      ---LHS of extra mappings
      extra = false,
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = false,
      pre_hook = nil,
      post_hook = nil,
    })
  end
})
