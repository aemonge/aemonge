local M = {}

table.insert(M, { "mfussenegger/nvim-dap",
  config = function ()
    require "which-key".register({
      d = {
        name = "Debugging tools",
        b = { ":DapToggleBreakpoint<cr>", "Toggle breakpoint" },
        c = { ":DapContinue<cr>", "Continue" },
        k = { ":DapTerminate<cr>", "Kill" },
        i = { ":DapStepInto<cr>", "Step into" },
        o = { ":DapStepOut<cr>", "Step out" },
        n = { ":DapStepOver<cr>", "Step Over" },
        t = { require("dapui").toggle(), "Toggle" }
      },
      v = { -- Python only, later on I should relay only on setting breakpoints and the DAP
        function()
          vim.fn.feedkeys('o', 'n')
          vim.fn.feedkeys("oprint('',)", 'i')
        end,
        "Debugging print",
      }
    }, {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    })
  end
})

table.insert(M, { "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "folke/neodev.nvim" },
  config = function()
    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })

  end
})

table.insert(M, { "mfussenegger/nvim-dap-python" })

return M
