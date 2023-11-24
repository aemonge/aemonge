local M = {}

table.insert(M, {
  "rcarriga/nvim-notify",
  priority = 99999,
  config = function()
    require("notify").setup({
      max_width = 90,
      background_colour = "#000000",
      stages = "fade_in_slide_out",
      timeout = 3500,
      top_down = false,
      level = vim.log.levels.WARN
    })
  end,
})

return M
