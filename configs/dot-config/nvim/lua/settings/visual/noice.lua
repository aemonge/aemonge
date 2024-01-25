-- lazy.nvim
local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        cmdline = {
            view = "cmdline_popup",
        },
        messages = {
            enabled = true,
            view_search = false,
            view = "notify",           -- default view for messages
            view_error = "notify",     -- view for errors
            view_warn = "notify",      -- view for warnings
            view_history = "messages", -- view for :messages
        },
        routes = {
        },
        presets = {
            long_message_to_split = true,
        },
        popupmenu = {
            enabled = true,
        },
        views = {
            cmdline_popup = {
                position = {
                    row = -2,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = "80%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
            },
        },
        notify = {
            enabled = true,
            view = "notify",
        }
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    }
}

return M
