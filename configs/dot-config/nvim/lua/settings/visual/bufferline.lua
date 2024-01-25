local M = {}

local selected = {
    bg = "#4f596e",
}
local unselected = {
    bg = "#152528"
}

local function getDiagnostics()
    -- Fetch diagnostics from different sources and aggregate them
    -- This is just a placeholder and will not work as is
    local diagnostics = {}
    diagnostics.nvim_lsp = vim.lsp.diagnostic.get_all()
    diagnostics.coc = vim.fn['coc#diagnostic#get_buffers']()
    -- Add more sources as needed
    return diagnostics
end

table.insert(M, {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        highlights = {
            fill               = selected,
            separator          = selected,
            separator_visible  = selected,
            -- indicator_selected = selected,
            -- indicator_visible  = unselected,
            separator_selected = unselected,
            buffer_selected    = unselected,
            modified_selected  = unselected,
            tab_selected       = unselected,
            background         = {
                bg = selected.bg,
                fg = '#CECECE',
            },
        },
        options = {
            custom_areas = {
                right = function()
                    local result = {}
                    table.insert(result, {
                        text = ' ' .. '  ' .. os.date('%H:%M') .. ' ', guifg = "#EC5241"
                    })
                    return result
                end,
            },
            mode = "tabs",
            sort_by = "tabs",
            numbers = "none",              -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
            close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
            indicator = {
                style = {
                    icon = "▎",
                },
            },
            buffer_close_icon = "",
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "寧",
            right_trunc_marker = "嶺",
            max_name_length = 30,
            max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
            tab_size = 21,
            themable = true,
            diagnostics = false, -- Its slow on updating | "nvim_lsp" | "coc",
            -- diagnostics_indicator = function(count, level)
            --     local icon = level:match("error") and " " or ""
            --     return " " .. icon .. count
            -- end,
            -- diagnostics_update_in_insert = true,
            offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
            show_buffer_icons = false,
            show_buffer_close_icons = false,
            show_close_icon = false,
            show_tab_indicators = false,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            separator_style = "thin",   -- | "thick" | "thin" | { 'any', 'any' },
            enforce_regular_tabs = true,
            always_show_bufferline = false,
        },
    }
})

return M
