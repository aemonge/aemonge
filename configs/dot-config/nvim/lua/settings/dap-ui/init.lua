local M = {}

local cache = {}


table.insert(M, {
    "rcarriga/nvim-dap-ui",
    ft = require("file-types")({
        "languages", "dap"
    }),
    dependencies = {
        "mfussenegger/nvim-dap",
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
                    }
                })
            else
                cb({
                    type = 'executable',
                    command = adapter_python_path,
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                        source_filetype = 'python',
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
            floating = {
                max_height = 0.9,
                max_width = 0.5, -- Floats will be treated as percentage of your screen.
                border = "rounded",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.65, position = "left" },
                        { id = "stacks", size = 0.35, position = "right" },
                    },
                    position = "bottom",
                    size = 0.15,
                },
                {
                    elements = {
                        { id = "console", size = 0.5, position = "left" },
                        { id = "watches", size = 0.5, position = "right" },
                    },
                    position = "bottom",
                    size = 15,
                },
                {
                    elements = {
                        { id = "repl", size = 1 },
                    },
                    position = "bottom",
                    size = 0.15,
                },
            }
        })

        vim.fn.sign_define("DapBreakpoint", {
            text = "🛑",
            texthl = "",
            linehl = "",
            numhl = ""
        }
        )
        -- Set status line to show the name and buffer of the dap file types
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
            pattern = require("file-types")({ "dap", }),
            command = "setlocal statusline=%f",
            desc = "Display the name of the DAP UI section"
        })

        -- Trigger completion
        vim.cmd(
            "au FileType dap-repl lua require('dap.ext.autocompl').attach({auto = false})")
        vim.cmd([[
      au FileType dap-repl lua vim.api.nvim_buf_set_keymap(0, 'i', '<Tab>', "pumvisible() ? '<C-n>' : '<Tab>'", {expr = true, noremap = true})
    ]])
    end
})

return M
