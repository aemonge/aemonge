local M = { "lcheylus/overlength.nvim",
  config = function ()
    require"overlength".setup({
      bg = "#692f2c",
      textwidth_mode = 1,
      default_overlength = textwidth,
      grace_length = 5,
      disable_ft = {
        '', 'terminal', 'qf', 'help', 'man', 'scratch',
        'packer', 'NvimTree', 'Telescope', 'WhichKey',
        'html', 'markdown', 'text',
      }
    })
  end
}

return M
