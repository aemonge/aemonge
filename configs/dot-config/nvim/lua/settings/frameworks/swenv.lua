local M = {}
-- https://github.com/linux-cultist/venv-selector.nvim
table.insert(M, {
    "AckslD/swenv.nvim",
    config = function()
        local swenv = require("swenv")
        swenv.setup({
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
        })
    end
})

return M
