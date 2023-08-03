local M = {}

-- Mappings for `expr = true`
M.i_exp = {
    ["<c-o>"] = { 'coc#refresh()', "Trigger Completion" },
    ["<c-j>"] = { '<Plug>(coc-snippets-expand-jump)', "Trigger Snippets" },
    ["<c-k>"] = {
        'coc#pum#visible() ? coc#pum#confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"',
        "Confirm Selection"
    },
    ["<c-n>"] = {
        'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
        "Next selection"
    },
    ["<c-p>"] = { 'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-h>"', "Prev selection" },
    ["<TAB>"] = {
        'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
        "Next selection"
    },
    ["<S-TAB>"] = { 'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-h>"', "Prev selection" }
}

M.iOpts_exp = {
    mode = "i",
    replace_keycodes = false,
    expr = true,
    prefix = nil,
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

-- Mappings without `expr = false`
M.i = {
    ["<c-s>"] = { '<C-X><C-S>', "Trigger spelling completion." },
    -- ["<c-f>"] = { '<C-X><C-F>', "Trigger file completion." },
}
M.iOpts = {
    mode = "i",
    noremap = true,
    silent = true,
    nowait = true,
}

return M
