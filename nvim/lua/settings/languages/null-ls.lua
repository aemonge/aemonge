local M = {}

-- Helper function to get the path to the specified executable from the virtual environment
local get_python_sources = require("settings.languages.null-ls-python")

table.insert(M, {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = require("file-types")({
        "markup",
        "languages",
        "frameworks",
    }),
    dependencies = {
        "williamboman/mason.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-null-ls").setup({
            automatic_installation = false,
            automatic_setup = true, -- Recommended, but optional
        })
        require("null-ls").setup({
            sources = get_python_sources(),
        })
        require("mason-null-ls").setup_handlers() -- If `automatic_setup` is true.
    end,
})

return M
