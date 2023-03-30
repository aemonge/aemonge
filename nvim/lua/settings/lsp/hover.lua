local M = {}

table.insert(M, {
    "lewis6991/hover.nvim",
    event = "InsertEnter",
    ft = require("file-types")({
        "languages",
        "frameworks",
    }),
    config = function()
        require("hover").setup({
            init = function()
                require("hover.providers.lsp")
                require("hover.providers.dictionary")
            end,
            preview_opts = {
                border = "rounded",
            },
        })

        -- Setup keymaps
        vim.keymap.set(
            "n",
            "K",
            require("hover").hover,
            { desc = "hover.nvim" }
        )
    end,
})

return M
