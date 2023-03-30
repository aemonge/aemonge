local function t(str) --TermCodes
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local t_mappings = {
    ["<ESC><ESC>"] = { t("<C-\\><C-N>"), "Go to normal mode" },
    ["<c-h>"] = { t("<C-\\><C-n><c-w>h"), "Go right" },
    ["<c-l>"] = {
        [""] = { t("<C-\\><C-n><c-w>l"), "Go left" },
        ["<c-l>"] = { [[<C-\><C-N>:lua ClearTerm()<CR>]], "Send clear" },
    },
    ["<c-k>"] = {
        [""] = { t("<C-\\><C-n><c-w>k"), "Go up" },
        ["<c-k>"] = { t("<C-\\><C-n>gt<cr>"), "Next tab" },
    },
    ["<c-j>"] = {
        [""] = { t("<C-\\><C-n><c-w>j"), "Go down" },
        ["<c-j>"] = { t("<C-\\><C-n>gT<cr>"), "Previous tab" },
    },
    -- ['<c-p>'] = { t 'nvr -cc "cd $(pwd) | Telescope find_files" <CR>', "Open files in CWD" },
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

return t_mappings
