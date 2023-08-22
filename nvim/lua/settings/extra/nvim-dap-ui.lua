local M = {}

table.insert(M, {
    "rcarriga/nvim-dap-ui",
    ft = require("file-types")({
        "languages",
    }),
    dependencies = {
        "mfussenegger/nvim-dap"
    },
    config = function()
        local dapui = require("dapui")
        dapui.setup()

        require("which-key").register({
            v = {
                name = "+dap (debugger)",
                c = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
                l = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
                j = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
                k = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },
                b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
                r = { "<cmd>lua require'dap'.repl.open()<CR>", "Open REPL" },
                v = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle DAP UI" },
            }
        }, {
            mode = { "n" },
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end
})

return M
