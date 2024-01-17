local M = {}

local function on_open(win)
    if vim.g.last_notification_id then
        require("notify").dismiss(vim.g.last_notification_id)
    end
end

table.insert(M, {
    "rcarriga/nvim-notify",
    priority = 99999,
    opts = {
        max_width = 90,
        background_colour = 'NONE', -- "#000000",
        timeout = 3500,
        top_down = false,
        level = vim.log.levels.WARN,
        stages = "fade_in_slide_out",
        render = "wrapped-compact",
        -- on_open = on_open
    }
})

return M
