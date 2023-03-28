local M = {}

table.insert(M, { "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
    "folke/neodev.nvim"
  },
  config = function ()
    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    require('dap-python').test_runner = 'pytest'
    require "which-key".register({
      d = {
        name = "Debugging tools",
        b = { ":DapToggleBreakpoint<cr>", "Toggle breakpoint" },
        c = { ":DapContinue<cr>", "Continue" },
        k = { ":DapTerminate<cr>", "Kill" },
        i = { ":DapStepInto<cr>", "Step into" },
        o = { ":DapStepOut<cr>", "Step out" },
        n = { ":DapStepOver<cr>", "Step Over" },
        t = { require"dapui".toggle, "Toggle" },
        s = { require"dapui".setup, "Setup DAP" },
        M = { require('dap-python').test_method, "Test method"},
        C = { require('dap-python').test_class, "Test class"}
      },
    }, {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    })
    require "which-key".register({
      d = { [[<Esc>:lua require('dap-python').debug_selection()]], "Debug Selection "},
      D = { -- Python only, later on I should relay only on setting breakpoints and the DAP
        function()
          vim.fn.feedkeys('o', 'n')
          vim.fn.feedkeys("oprint('',)", 'i')
        end,
        "Debugging print",
      }
    }, {
      mode = "v",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    })
  end
})

return M
