local C = {}

C.whichKey = {
    plugins = {
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        },
        presets = {
            operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false,      -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = false,      -- default bindings on <c-w>
            nav = false,          -- misc bindings to work with windows
            z = true,             -- bindings for folds, spelling and others prefixed with z
            g = false,            -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = " ", -- symbol prepended to a group
    },
    window = {
        border = "double", -- none, single, double, shadow
        winblend = 15,
    },
    layout = {
        height = { min = 2, max = 10 }, -- min and max height of the columns
        align = "center",               -- align columns left, center or right
    },
    disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
    },
}

C.lazy = {
    install = {
        colorscheme = { "nordfox" },
    },
    ui = {
        border = "rounded",
    },
    checker = {
        enabled = true
    }
}

return C
