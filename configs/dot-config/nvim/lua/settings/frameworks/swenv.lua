local M = {}
table.insert(M, {
    "AckslD/swenv.nvim",
    opts = {
        venvs_path = vim.fn.expand('~/.conda/envs'),
        post_set_venv = function()
            local timer = vim.loop.new_timer()
            -- Check every 250ms if g:coc_status exists
            timer:start(250, 250, vim.schedule_wrap(function()
                if vim.g.coc_status then
                    timer:stop()
                    vim.cmd([[:CocRestart]])
                end
            end))
        end
    },
    keys = {
        { '<leader>ls', function() require('swenv.api').pick_venv() end, { silent = true, noremap = true, nowait = true }, mode = "n", desc = "select py-virtual environment" },
    }
})

return M
