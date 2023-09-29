local M = {}
-- https://github.com/linux-cultist/venv-selector.nvim
table.insert(M, {
    "AckslD/swenv.nvim",
    config = function()
        require("swenv").setup({
            venvs_path = vim.fn.expand('~/.conda/envs')
        })
        require("which-key").register({
            s = {
                function() require("swenv.api").pick_venv() end,
                "Switch Python Environment"
            }
        }, {
            mode = { "n" },
            prefix = "<leader>l",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        }
        )
    end
})

return M
