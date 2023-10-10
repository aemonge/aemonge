local venv = {
    "venv",
    colored = true,
    function()
        local utils = require("lvim.core.lualine.utils")
        if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV")
                or os.getenv("VIRTUAL_ENV")
            if venv and venv ~= "base" then
                local icons = require("nvim-web-devicons")
                local py_icon, _ = icons.get_icon(".py")
                return string.format(
                    " " .. py_icon .. " (%s)",
                    utils.env_cleanup(venv)
                )
            end
        end
        return ""
    end,
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic", "coc" },
    sections = { 'error', 'warn' },
    symbols = { error = ' ', warn = ' ', info = '', hint = '𥉉' },
    colored = false,
    update_in_insert = true,
    always_visible = true,
}

local diff = {
    "diff",
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
}

local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local M = {
    "nvim-lualine/lualine.nvim",
    config = function()
        local disabled_filetypes, disabled_buftypes = require("settings.visual.raw-types")
        local material_theme = require("lualine.themes.material")

        material_theme.normal.c = { fg = '#CCCECF', bg = '#4F596E' }
        material_theme.normal.x = { fg = '#CCCECF', bg = '#2E3C43' }

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = material_theme,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = disabled_filetypes,
                disabled_buftypes = disabled_buftypes,
                always_divide_middle = false,
            },
            sections = {
                lualine_a = { branch },
                lualine_b = { diff },
                lualine_c = {
                    { "nvim-tree" },
                    -- { "g:coc_status" },
                    {
                        "filename",
                        path = 1,
                        shorting_target = 80,
                    },
                },
                lualine_x = {
                    { "location" },
                    { 'g:coc_status', 'bo:filetype' },
                },
                lualine_y = {
                    diagnostics,
                },
                lualine_z = { { "swenv", icon = "", color = { fg = '#3B4252', bg = '#7E98BA' } } }
                -- lualine_z = { 'os.date("%I:%M:%S", os.time())' },
            },
            inactive_sections = {
                lualine_a = { branch },
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        shorting_target = 80,
                    },
                },
                lualine_x = {},
                lualine_y = { filetype },
                lualine_z = {},
            }
        })
    end,
}

return M
