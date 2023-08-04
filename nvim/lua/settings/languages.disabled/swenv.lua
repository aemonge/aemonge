local M = {}

table.insert(M, {
    "AckslD/swenv.nvim",
    ft = require("file-types")({
        "languages",
    }),
    config = function()
        require("swenv").setup({
            get_venvs = function(venvs_path)
                return require("swenv.api").get_venvs(venvs_path)
            end,
            venvs_path = vim.fn.expand("~/.conda/envs"),
            post_set_venv = function()
                vim.cmd(":LspRestart<cr>")
            end,
        })
    end,
})

return M
