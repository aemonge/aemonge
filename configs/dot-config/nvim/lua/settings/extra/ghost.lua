local M = {
    "subnut/nvim-ghost.nvim",
    lazy = true,
    init = function()
        require "which-key".register({
            t = {
                G = { function()
                    vim.cmd [[
              silent! Lazy load nvim-ghost.nvim
            ]]
                end, "Start Ghost Text"
                }
            }
        }, { prefix = '<leader>', buffer = nil, silent = true, noremap = true, nowait = true })
    end,
    config = function()
        require "which-key".register({
            t = {
                G = { function()
                    vim.cmd [[
              silent! call nvim_ghost#disable()
              silent! call nvim_ghost#kill_server()<cr>
              silent! call nvim_ghost#start_server()
              silent! call nvim_ghost#enable()
            ]]
                end, "Re-Start Ghost server"
                }
            }
        }, { prefix = '<leader>', buffer = nil, silent = true, noremap = true, nowait = true })
    end
}

return M
