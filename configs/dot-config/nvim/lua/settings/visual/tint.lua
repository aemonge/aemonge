local function is_disabled_filetype(filetype, disabled_filetypes)
    for _, disabled_filetype in ipairs(disabled_filetypes) do
        if filetype == disabled_filetype then
            return true
        end
    end
    return false
end

local M = {
    "levouh/tint.nvim",
    config = function()
        require("tint").setup({
            -- tint = 0,                                              -- Darken colors, use a positive value to brighten
            saturation = 0.9, -- Saturation to preserve
            focus = {
                "WinEnter", "BufEnter", "TermLeave", "CmdwinLeave"
            },
            -- transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
            tint_background_colors = false, -- Tint background portions of highlight groups
            highlight_ignore_patterns = {   -- Highlight group patterns to ignore, see `string.find`
                "WinSeparator", "Status.*"
            },

            window_ignore_function = function(winid)
                local bufid = vim.api.nvim_win_get_buf(winid)
                local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
                local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
                local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
                -- Do not tint `terminal` or floating windows, tint everything else
                local disabled_filetypes, _ = require("settings.visual.raw-types")
                return buftype == "terminal" or floating or is_disabled_filetype(filetype, disabled_filetypes)
            end
        })
    end,
}

return M