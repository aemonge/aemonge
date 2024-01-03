local M = {
    "subnut/nvim-ghost.nvim",
    lazy = true,
    keys = {
        {
            '<leader>tG',
            function()
                vim.cmd [[
              silent! Lazy load nvim-ghost.nvim
            ]]
            end,
            { noremap = true, silent = true, nowait = true },
            mode = "n",
            desc = "Start Ghost Text"
        },
        {
            '<leader>tG',
            function()
                vim.cmd [[
              silent! call nvim_ghost#disable()
              silent! call nvim_ghost#kill_server()<cr>
              silent! call nvim_ghost#start_server()
              silent! call nvim_ghost#enable()
            ]]
            end,
            { noremap = true, silent = true, nowait = true },
            mode = "n",
            desc = "Re-Start Ghost server"
        },
    },
}

return M
