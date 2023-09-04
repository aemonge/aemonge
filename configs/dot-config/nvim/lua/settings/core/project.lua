local M = {}

table.insert(M, {
    "ahmedkhalf/project.nvim",
    priority = 100 - 1,
    config = function()
        require("project_nvim").setup({
            patterns = {
                ".env",
                ".git",
                "_darcs",
                ".hg",
                ".bzr",
                ".svn",
                "Makefile",
                "package.json",
                "requirements.txt",
                "Gemfile",
                "environment.yml",
                "README.rst",
                "README.md",
                "pyproject.toml",
                "tox.ini",
            },
        })
        require('telescope').load_extension('projects')
        require("which-key").register({
            p = { [[:Telescope projects<CR>]], "Projects" }
        }, {
            mode = { "n" },
            prefix = "<leader>t",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end,
})

return M
