local M = {}

M.n = {
    a = { "<CMD>lua _G.code_action_priority()<CR>", "Code actions" },
    f = { "<Plug>(coc-format)", "Format file" },

    ['.'] = { ":<C-u>CocList commands<cr>", "Show CoC Commands" },
    r = { ":CocRestart<CR>", "Restart CoC" },
    C = { ":CocConfig<CR>", "Configuration" },
    c = { ":CocLocalConfig<CR>", "Local Configuration" },
    l = { ":lua require('lazy').update({show = false})<CR>", "Lazy and CoC Update" },
    L = { ":Lazy<CR>", "Lazy" }
}

M.nOpts = {
    mode = "n",
    prefix = "<leader>l",
    name = "LSP and COC actions",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

M.v = {
    a = { "<CMD>lua _G.code_action_priority()<CR>", "Code actions" },
    f = { "<Plug>(coc-format-selected)", "Format" },
}

M.vOpt = {
    mode = "v",
    prefix = "<leader>l",
    name = "LSP and COC actions",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
