local function globalCondition()
    -- If has tabs
    return vim.fn.tabpagenr('$') > 1
end

local function search_count()
    if vim.api.nvim_get_vvar("hlsearch") == 1 then
        local search_expr = vim.fn.getreg("/")
        local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })

        if res.total > 0 then
            return string.format("/%s/ %d/%d", search_expr, res.current, res.total)
        end
    end
    return ""
end

local function get_mode_symbol()
    local mode = vim.api.nvim_get_mode().mode
    local mode_char = mode:sub(1, 1)
    local mode_symbol = {
        ["n"] = { symbol = "" },
        ["i"] = { symbol = "" },
        ["r"] = { symbol = "" },
        ["v"] = { symbol = "" },
        ["V"] = { symbol = "" },
        ["CTRL-V"] = { symbol = "" },
        ["b"] = { symbol = "" },
        ["s"] = { symbol = "" },
        ["c"] = { symbol = "" },
        ["t"] = { symbol = "" },
        ["R"] = { symbol = "" },
        ["!"] = { symbol = "" },
    }
    return mode_symbol[mode_char].symbol or mode_char
end


local diagnostics = {
    "diagnostics",
    cond = globalCondition,
    sources = { "nvim_lsp", "nvim_diagnostic", "coc" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { warn = " ", error = " ", info = " ", hint = "𥉉" },
    colored = true,
    update_in_insert = true,
    subject = function(data)
        local result = ""
        for name, count in pairs(data) do
            if count ~= 0 then
                result = result .. (diagnostics.symbols[name] or name) .. count .. " "
            end
        end
        return result
    end
}

local diff = {
    "diff",
    draw_empty = true,
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
}

local M = {
    "nvim-lualine/lualine.nvim",
    -- after = "noice.nvim",
    config = function()
        local disabled_filetypes, disabled_buftypes = require("settings.visual.raw-types")
        local material_theme = require("lualine.themes.material")
        -- local winbar_bg = { bg = "#291E15" }
        local theme = {
            insert = {
                a = { fg = "#7E98BA", bg = "#2E3C43" },
                b = { fg = "#7798A8", bg = "#152528" },
                y = { fg = "#687175", bg = "#2E423C" },
                z = material_theme.normal.z
            },
            visual = {
                a = { bg = "#C2BF76", fg = "#2E3C43" },
                b = { fg = "#7798A8", bg = "#152528" },
                y = { fg = "#687175", bg = "#2E423C" },
                z = material_theme.normal.z
            },
            replace = {
                a = { bg = "#422E30", fg = "#2E3C43" },
                b = { fg = "#7798A8", bg = "#152528" },
                y = { fg = "#687175", bg = "#2E423C" },
                z = material_theme.normal.z
            },
            command = {
                a = { bg = "#E5C07B", fg = "#2E3C43" },
                b = { fg = "#7798A8", bg = "#152528" },
                y = { fg = "#687175", bg = "#2E423C" },
                z = material_theme.normal.z
            },
            normal = {
                a = { fg = "#7798A8", bg = "#2E3C43" },
                b = { fg = "#7798A8", bg = "#152528" },
                c = { fg = "#7798A8", bg = "#151929" },
                x = { fg = "#7798A8", bg = "#152528" },
                y = { fg = "#7798A8", bg = "#2E423C" },
                z = material_theme.normal.z
            },
            -- inactive_winbar = {
            --     a = winbar_bg,
            --     b = winbar_bg,
            --     c = winbar_bg,
            --     x = winbar_bg,
            --     z = winbar_bg,
            -- },
            -- winbar = {
            --     a = winbar_bg,
            --     b = winbar_bg,
            --     c = winbar_bg,
            --     x = winbar_bg,
            --     z = winbar_bg,
            -- },
            inactive = {
                a = { fg = "#CCCECF", bg = "none" },
                c = { fg = "#CCCECF", bg = "none" },
                y = { fg = "#CCCECF", bg = "none" },
            }
        }

        require("lualine").setup({
            options           = {
                icons_enabled        = true,
                theme                = theme,
                component_separators = { left = "", right = "" },
                section_separators   = { left = "", right = "" },
                disabled_filetypes   = disabled_filetypes,
                disabled_buftypes    = disabled_buftypes,
                condition            = function()
                    return vim.fn.tabpagenr("$") > 1
                end,
            },
            sections          = {
                lualine_a = {
                    {
                        get_mode_symbol,
                        color = { fg = "#CCCECF", bg = "#2E2E42" },
                        cond = globalCondition,
                    },
                    {
                        "branch",
                        icons_enabled = true,
                        colored = false,
                        icon = "",
                        cond = globalCondition,
                    }
                },
                lualine_b = {
                    diagnostics
                    -- diff
                },
                lualine_c = {
                    {
                        "nvim-tree",
                        color = { bg = "#4f596e" },
                        cond = globalCondition,
                    },
                    {
                        "filename",
                        path = 3,
                        cond = globalCondition,
                        -- color = {
                        --     fg = "#cdcecf", bg = "#4f596e"
                        -- }
                    },
                },
                lualine_x = {
                    {
                        search_count,
                        type = "lua_expr",
                        cond = globalCondition,
                    },
                    -- {
                    --     require("noice").api.status.message.get,
                    --     cond = require("noice").api.status.message.has,
                    -- },
                },
                lualine_y = {
                    {
                        "g:coc_status",
                        "bo:filetype",
                        cond = globalCondition,
                    },
                },
                lualine_z = {
                    {
                        "swenv",
                        cond = function()
                            return globalCondition() and vim.bo.filetype == "python"
                        end,
                        icon = "",
                        color = { fg = "#7798A8", bg = "#151929" },
                    }
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {
                    {
                        "branch",
                        icons_enabled = true,
                        draw_empty = false,
                        icon = "",
                        color = { fg = "#CCCECF", bg = "none" },
                        cond = globalCondition,
                    }
                },
                lualine_c = { {
                    "diff",
                    cond = globalCondition,
                } },
                lualine_x = {
                    {
                        "filename",
                        path = 3,
                        color = {
                            fg = "#CCCECF", bg = "none"
                        },
                        cond = globalCondition,
                    },
                },
                lualine_y = { {
                    "filetype",
                    cond = globalCondition,
                } },
                lualine_z = {},
            },
            -- inactive_winbar = {
            --     lualine_a = {},
            --     lualine_b = {
            --         {
            --             "filename",
            --             path = 1,
            --             color = {
            --                 fg = "#CCCECF", bg = "none"
            --             }
            --         },
            --     },
            --     lualine_z = { diagnostics },
            -- },
            -- winbar = {
            --     lualine_a = { get_mode_symbol },
            --     lualine_b = { diagnostics },
            --     lualine_c = {
            --         { "nvim-tree", color = { bg = "#4f596e" } },
            --         {
            --             "filename",
            --             path = 3,
            --             color = {
            --                 fg = "#cdcecf", bg = "#4f596e"
            --             }
            --         },
            --     },
            --     lualine_y = {},
            --     lualine_z = { {
            --         breadcrumbs,
            --         color = {
            --             fg = "#EDDB8A", bg = "#4f596e"
            --         },
            --     } },
            -- }
        })
    end,
}

return M
