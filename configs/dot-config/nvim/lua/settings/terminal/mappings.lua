local function t(str) --TermCodes
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.M = {
    ["<C-o>"] = { t("<C-\\><C-N>"), "Go to normal mode" },

    ["<c-j>"] = {
        [""] = { t("<C-\\><C-n><c-w>W"), "Previous window" },
        ["<c-j>"] = { t("<C-\\><C-n>gT"), "Previous tab" },
    },
    ["<c-k>"] = {
        [""] = { t("<C-\\><C-n><c-w>w"), "Next window" },
        ["<c-k>"] = { t("<C-\\><C-n>gt"), "Next tab" },
    },

    ["<c-t>"] = { t("<C-\\><C-n>:lua NewTermTab()<cr>"), "New term tab" },

    ["<c-w>"] = {
        name = "Split new Terminals",

        h = {
            t("<C-\\><C-n>:leftabove vsplit | terminal<cr>"),
            "Left",
        },
        j = {
            t("<C-\\><C-n>:rightbelow split | terminal<cr>"),
            "Down",
        },
        k = {
            t("<C-\\><C-n>:leftabove split | terminal<cr>"),
            "Up",
        },
        l = {
            t("<C-\\><C-n>:rightbelow vsplit | terminal<cr>"),
            "Right",
        },
    },
}

M.O = {
    mode = "t",
    prefix = nil,
    buffer = nil,
    silent = true,
    nowait = true,
}

return M
