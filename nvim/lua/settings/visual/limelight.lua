local M = { "junegunn/limelight.vim",
  config = function ()
    vim.g.limelight_default_coefficient = 0.7
    vim.g.limelight_paragraph_span = 2
    vim.g.limelight_priority = -1
  end
}

return M
