local M = {}

table.insert(M, {
    "folke/which-key.nvim",
    priority = 1,
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 180
        local wk = require("which-key")
        wk.setup({
            plugins = {
                spelling = {
                    enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                },
                presets = {
                    operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                    motions = false, -- adds help for motions
                    text_objects = false, -- help for text objects triggered after entering an operator
                    windows = false, -- default bindings on <c-w>
                    nav = false, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = false, -- bindings for prefixed with g
                },
            },
            -- add operators that will trigger motion and text object completion
            -- to enable all native operators, set the preset / operators plugin above
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "➜", -- symbol used between a key and it's label
                group = " ", -- symbol prepended to a group
            },
            window = {
                border = "double", -- none, single, double, shadow
                winblend = 15,
            },
            layout = {
                height = { min = 2, max = 10 }, -- min and max height of the columns
                align = "center", -- align columns left, center or right
            },
            disable = {
                buftypes = {},
                filetypes = { "TelescopePrompt" },
            },
        })

        wk.register(require("settings.mappings.toggler"), {
            mode = "n",
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })

        wk.register(require("settings.mappings.current_file_ops"), {
            mode = "n",
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })

        wk.register(require("settings.mappings.navigation"), {
            mode = "n",
            prefix = nil,
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })

        wk.register(require("settings.mappings.terminal"), {
            mode = "t",
            prefix = nil,
            buffer = nil,
            silent = true,
            -- noremap = true,
            nowait = true,
        })
    end,
})

return M
