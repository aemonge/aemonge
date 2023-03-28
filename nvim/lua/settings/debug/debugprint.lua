local M = {}

table.insert(M, {
    "andrewferrier/debugprint.nvim",
    config = function()
        local opts = {
            create_keymaps = false,
            create_commands = false,
        }
        require("debugprint").setup(opts)
        local fn = function()
            -- Note: setting `expr=true` and returning the value are essential
            -- It's also important to use motion = true for operator-pending motions
            return require("debugprint").debugprint({ motion = true, variable = true })
        end

        require("which-key").register({
            d = {
                name = "Debugger",
                {
                    p = { fn, "Debug Print" },
                },
            },
        }, {
            mode = "n",
            prefix = "<leader>",
            buffer = nil,
            expr = true,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end,
})

return M
