local function breadcrumbs()
    local items = vim.b.coc_nav
    local t = {}
    for k, v in ipairs(items) do
        t[#t + 1] = "" .. (type(v.label) == "string" and v.label .. "" or "")
            .. (v.name or "")
        if next(items, k) ~= nil then
            t[#t + 1] = " "
        end
    end
    return table.concat(t)
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
    sources = { "nvim_lsp", "nvim_diagnostic", "coc" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { warn = " ", error = " ", info = " ", hint = "𥉉" },
    colored = true,
    update_in_insert = true,
    always_visible = false,
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
                b = { fg = "#7E98BA", bg = "#3B4252" },
                y = { fg = "#CCCECF", bg = "#4F596E" },
                z = material_theme.normal.z
            },
            visual = {
                a = { bg = "#628B4A", fg = "#2E3C43" },
                b = { fg = "#7E98BA", bg = "#3B4252" },
                y = { fg = "#CCCECF", bg = "#4F596E" },
                z = material_theme.normal.z
            },
            replace = {
                a = { bg = "#D16969", fg = "#2E3C43" },
                b = { fg = "#7E98BA", bg = "#3B4252" },
                y = { fg = "#CCCECF", bg = "#4F596E" },
                z = material_theme.normal.z
            },
            command = {
                a = { bg = "#E5C07B", fg = "#2E3C43" },
                b = { fg = "#7E98BA", bg = "#3B4252" },
                y = { fg = "#CCCECF", bg = "#4F596E" },
                z = material_theme.normal.z
            },
            normal = {
                a = { fg = "#7E98BA", bg = "#2E3C43" },
                b = { fg = "#7E98BA", bg = "#3B4252" },
                c = { fg = "#CCCECF", bg = "#4F596E" },
                x = { fg = "#CCCECF", bg = "#4F596E" },
                y = { fg = "#CCCECF", bg = "#4F596E" },
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
                always_visible       = false,
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
                        color = { fg = "#CCCECF", bg = "#4F596E" }
                    },
                },
                lualine_b = {
                    {
                        "branch",
                        icons_enabled = true,
                        draw_empty = true,
                        colored = false,
                        icon = "",
                    },
                    diff
                },
                lualine_c = {
                    { "nvim-tree", color = { bg = "#4f596e" } },
                    {
                        "filename",
                        path = 0,
                        color = {
                            fg = "#cdcecf", bg = "#4f596e"
                        }
                    },
                },
                lualine_x = {
                    {

                        breadcrumbs,
                        color = {
                            fg = "#EDDB8A", bg = "#4f596e"
                        },
                        always_visible = false,
                    },
                    diagnostics,
                    -- {
                    --     require("noice").api.status.message.get,
                    --     cond = require("noice").api.status.message.has,
                    -- },
                },
                lualine_y = {
                    { search_count, type = "lua_expr" },
                    {
                        -- "g:coc_status",
                        "bo:filetype",
                    },
                },
                lualine_z = {
                    {
                        "swenv",
                        cond = function()
                            return vim.bo.filetype == "python"
                        end,
                        icon = "",
                        color = { fg = "#3B4252", bg = "#7E98BA" }
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
                        color = { fg = "#CCCECF", bg = "none" }
                    }
                },
                lualine_c = { "diff" },
                lualine_x = {
                    {
                        "filename",
                        path = 3,
                        color = {
                            fg = "#CCCECF", bg = "none"
                        }
                    },
                },
                lualine_y = {
                    "filetype"
                },
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
            --         always_visible = false
            --     } },
            -- }
        })
    end,
}

return M
