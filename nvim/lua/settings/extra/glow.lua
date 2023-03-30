local M = {
    "npxbr/glow.nvim",
    ft = { "markdown", "quarto", "qmd" },
    config = function()
        require("glow").setup({
            pager = true,
            width = 150, -- TODO: Change to a bigger number such as 160, once you set the text with to 150 on md/text/...
        })
    end,
}

return M
