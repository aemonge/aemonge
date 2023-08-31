local venv = {
    "venv",
    colored = true,
    function()
        local utils = require("lvim.core.lualine.utils")
        if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV")
                or os.getenv("VIRTUAL_ENV")
            if venv then
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
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
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
        disabled_filetypes, disabled_buftypes = require("settings.visual.raw-types")
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "material",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = disabled_filetypes,
                disabled_buftypes = disabled_buftypes,
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { branch },
                lualine_b = { diagnostics },
                lualine_c = {
                    { "nvim-tree" },
                    { "filename", path = 1, shorting_target = 80 },
                },
                lualine_x = { diff, "location" },
                lualine_y = {
                    venv,
                    "require'lsp-status'.status()",
                    filetype,
                },
                lualine_z = { 'os.date("%I:%M:%S", os.time())' },
            },
            inactive_sections = {
                lualine_a = { branch },
                lualine_b = {},
                lualine_c = {
                    { "filename", path = 1, shorting_target = 80 },
                },
                lualine_x = {},
                lualine_y = { filetype },
                lualine_z = {},
            }
        })
    end,
}

return M
