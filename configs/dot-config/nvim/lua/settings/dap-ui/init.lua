local M = {}

table.insert(M, {
    "rcarriga/nvim-dap-ui",
    ft = require("file-types")({
        "languages", "dap"
    }),
    dependencies = {
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python"
    },
    config = function()
        local dap = require("dap")
        local F = require("settings.dap-ui.helpers")
        local adapter_python_path = adapter_python_path and vim.fn.expand(vim.fn.trim(adapter_python_path), true) or
            'python3'
        dap.adapters.python = function(cb, config)
            if config.request == 'attach' then
                cb({
                    type = "server",
                    port = "5678",
                    host = "127.0.0.1",
                    options = {
                        source_filetype = "python",
                        justMyCode = true
                    }
                })
            else
                cb({
                    type = 'executable',
                    command = adapter_python_path,
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                        source_filetype = 'python',
                        justMyCode = true
                    }
                })
            end
        end

        dap.configurations.python = {
            {
                type = "python",
                request = "attach",
                name = 'Server at 127.0.0.1:5678',
            },
            {
                type = 'python',
                request = 'launch',
                name = 'File',
                program = '${file}',
                args = function()
                    -- TODO: Wait for this file to be saved here
                    return F.openBufferAndReturnArgs(vim.fn.expand("%:t"))
                end
            }
        }

        require("dapui").setup({
            force_buffers = false,
            layouts = {
                {
                    elements = {
                        { id = "watches", size = 1 },
                    },
                    position = "bottom",
                    size = 0.05,
                },
                {
                    elements = {
                        { id = "scopes", size = 0.70, position = "left" },
                        { id = "stacks", size = 0.30, position = "right" },
                    },
                    position = "bottom",
                    size = 0.15,
                },
                {
                    elements = {
                        { id = "repl", size = 1 },
                    },
                    position = "bottom",
                    size = 0.20,
                },
            }
        })

        vim.fn.sign_define("DapBreakpoint", {
            text = "🛑",
            texthl = "",
            linehl = "",
            numhl = ""
        })

        -- Set status line to show the name and buffer of the dap file types
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
            pattern = require("file-types")({ "dap", }),
            command = "setlocal statusline=%f",
            desc = "Display the name of the DAP UI section"
        })


        vim.cmd [[ au FileType dap-repl lua require('settings.dap-ui.repl').setup() ]]
        -- vim.cmd [[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]]
    end,
    keys = {
        { '<leader>v', desc = "🐞Debugger" },
        { '<leader>vv', "<cmd>lua require'dapui'.toggle()<CR>", { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Toggle DAP UI" },
        { '<leader>vr', "<cmd>lua require'dap'.run_last()<CR>", { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Run last" },
        { '<leader>vS', "<cmd>lua require'dap'.terminate()<CR>", { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Terminate" },
        { '<leader>vs', "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Continue" },
        { '<leader>vn', "<cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Step Over" },
        { '<leader>vi', "<cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Step Into" },
        { '<leader>vo', "<cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Step Out" },
        { '<leader>vd', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true, nowait = true }, mode = "n", desc = "Toggle Breakpoint" },
    }

})

return M
