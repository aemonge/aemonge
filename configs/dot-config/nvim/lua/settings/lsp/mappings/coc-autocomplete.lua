local wk = require("which-key")

wk.register({
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
}, {
    mode = "i",
    replace_keycodes = false,
    expr = true,
    prefix = nil,
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})

wk.register({
        ["<c-s>"] = { '<C-X><C-S>', "Trigger spelling completion." },
    },
    {
        mode = "i",
        noremap = true,
        silent = true,
        nowait = true,
    })
