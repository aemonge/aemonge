local M = {}

vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"

table.insert(M, {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "andymass/vim-matchup",
        "nvim-treesitter/nvim-treesitter-context",
        "theHamsta/nvim-treesitter-pairs",
    },
    ft = require("file-types")({
        "markup",
        "languages",
        "frameworks",
    }),
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "comment",
                "gitcommit",
                "gitignore",
                "markdown",
                "toml",
                "json",
                "json5",
                "lua",
                "python",
                "sql",
                "vim",
            },
            ignore_install = {
                "javascript",
                "PHP",
                "Java",
                "typescript",
                "html",
                "css",
                "ruby",
            },
            auto_install = true,
            context_commentstring = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        })
    end,
})

return M
