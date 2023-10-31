local wk = require("which-key")

wk.register({
    a = { "<CMD>lua _G.code_action_priority()<CR>", "Code actions" },
    f = { "<Plug>(coc-format)", "Format file" },

    -- s = { "<cmd>:VenvSelect<cr>", "Select V-Environment" },

    ['.'] = { ":<C-u>CocList commands<cr>", "Show CoC Commands" },
    r = { ":CocRestart<CR>", "Restart CoC" },
    C = { ":CocConfig<CR>", "Configuration" },
    c = { ":CocLocalConfig<CR>", "Local Configuration" },
    L = { ":lua require('lazy').update({show = false})<CR>", "Lazy and CoC Update" },
    l = { ":Lazy<CR>", "Lazy" },
    m = { ":CocList marketplace<cr>", "Coc Marketplace" }
}, {
    mode = "n",
    prefix = "<leader>l",
    name = "LSP and COC actions",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})

wk.register({
    a = { "<CMD>lua _G.code_action_priority()<CR>", "Code actions" },
    f = { "<Plug>(coc-format-selected)", "Format" },
}, {
    mode = "v",
    prefix = "<leader>l",
    name = "LSP and COC actions",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})
