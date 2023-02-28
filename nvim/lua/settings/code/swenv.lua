local M = {}

table.insert(M, { "AckslD/swenv.nvim",
  config = function ()
    require('swenv').setup({
      get_venvs = function(venvs_path)
        return require('swenv.api').get_venvs(venvs_path)
      end,
      venvs_path = vim.fn.expand('~/.anaconda3/envs'),
      post_set_venv = function ()
        vim.cmd(":LspRestart<cr>")
      end
    })

    require "which-key".register({
      l = {
        name = "Lsp Extended Actions",
        e = { require('swenv.api').pick_venv, "Pick conda environment"},
        r = { ":LspRestart<cr>", "Restart"},
        f = { ":lua vim.lsp.buf.format()<cr>", "Format"},
        i = { ":LspInfo<cr>", "Info"},
        m = { ":Mason<cr>", "Mason"},
        l = { ":Lazy<cr>", "Lazy"}
      }
    }, { prefix = '<leader>', buffer = nil, silent = true, noremap = true, nowait = true})
  end
})

return M
