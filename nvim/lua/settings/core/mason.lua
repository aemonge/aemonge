local M = {}

table.insert(M, {
    "williamboman/mason.nvim",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
        "data",
        "versionControl",
    }),
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })
        require("which-key").register(
            {
                l = {
                    m = { ":Mason<cr>", "Mason" },
                },
            },
            {
                prefix = "<leader>",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            }
        )
    end,
})

return M
