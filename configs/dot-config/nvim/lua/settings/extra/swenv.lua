local M = {}
-- https://github.com/linux-cultist/venv-selector.nvim
table.insert(M, {
    "AckslD/swenv.nvim",
    config = function()
        local swenv = require("swenv")
        swenv.setup({
            -- venvs_path = vim.fn.expand('~/.conda/envs'),
            -- get_venvs = function(venvs_path)
            --     return require("swenv").get_venvs(venvs_path)
            -- end,
            -- post_set_venv = vim.cmd [[":CocRestart<CR>"]]
            post_set_venv = function()
                vim.cmd.CocRestart()
            end
        })
    end
})

return M
