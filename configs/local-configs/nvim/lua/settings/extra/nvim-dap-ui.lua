local M = {}

table.insert(M, {
    "rcarriga/nvim-dap-ui",
    ft = require("file-types")({
        "languages",
    }),
    dependencies = {
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python"
    },
    config = function()
        require('dap-python').setup()
        require("dapui").setup({
            force_buffers = false,
            layouts = {
                {
                    elements = {
                        { id = 'console', size = 1 },
                    },
                    position = 'bottom',
                    size = 0.16,
                },
                {
                    elements = {
                        { id = 'repl', size = 1 },
                    },
                    position = 'bottom',
                    size = 0.24,
                },
                {
                    elements = {
                        { id = 'scopes',  size = 0.5 },
                        { id = 'watches', size = 0.5 },
                    },
                    position = 'right',
                    size = 0.35,
                },
            }
        })

        -- Set status line to show the name and buffer of the dap file types
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
            pattern = require("file-types")({ "dap", }),
            command = "setlocal statusline=%f",
            desc = "Display the name of the DAP UI section"
        })

        require("which-key").register({
            v = {
                name = "+dap (debugger)",
                v = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle DAP UI" },
                [','] = { "<cmd>lua require'dap'.run_last()<CR>", "Run last" },
                S = { "<cmd>lua require'dap'.terminate()<CR>", "Terminate" },
                s = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },

                n = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
                i = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
                o = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },

                d = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
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
