local M = {}

table.insert(M, {
    "rcarriga/nvim-notify",
    priority = 99999,
    config = function()
        require("notify").setup({
            background_colour = "#000000",
            max_width = 70,
            stages = "slide",
            timeout = 7500,
            top_down = false,
        })
    end,
})

return M
