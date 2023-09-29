local M = {}

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
        dap.adapters.python = function(cb)
            cb({
                type = "server",
                port = "5678",
                host = "127.0.0.1",
                options = {
                    source_filetype = "python",
                },
            })
        end

        dap.configurations.python = {
            {
                type = "python",
                request = "attach",
            },
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
                    size = 0.20,
                },
                {
                    elements = {
                        { id = "watches", size = 1 },
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
