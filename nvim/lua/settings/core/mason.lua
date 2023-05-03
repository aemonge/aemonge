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
            pip = {
                upgrade_pip = true,
            },
        })
        require("which-key").register(
            {
                l = {
                    name = "Lsp Extended Actions",
                    -- e = {
                    --     require("swenv.api").pick_venv,
                    --     "Pick conda environment",
                    -- },
                    r = { ":LspRestart<cr>", "Restart" },
                    f = { ":lua vim.lsp.buf.format()<cr>", "Format" },
                    i = { ":LspInfo<cr>", "Info" },
                    m = { ":Mason<cr>", "Mason" },
                    l = { ":Lazy<cr>", "Lazy" },
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
