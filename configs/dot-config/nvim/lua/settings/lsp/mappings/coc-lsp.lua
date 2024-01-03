local wk = require("which-key")

wk.register({
    a = { "<CMD>lua _G.code_action_priority()<CR>", "Code actions" },

    -- s = { "<cmd>:VenvSelect<cr>", "Select V-Environment" },

    ['.'] = { ":<C-u>CocList commands<cr>", "Show CoC Commands" },
    r = { ":CocRestart<CR>", "Restart CoC" },
    C = { ":CocConfig<CR>", "Configuration" },
    c = { ":CocLocalConfig<CR>", "Local Configuration" },
    L = { ":lua require('lazy').update({show = false})<CR>", "Lazy and CoC Update" },
    l = { ":Lazy<CR>", "Lazy" },
    M = { ":CocList marketplace<cr>", "Coc Marketplace" }
}, {
    prefix = "<leader>l",
})

wk.register({
    a = { "<CMD>lua _G.code_action_priority()<CR>", "Code actions" },
}, {
    mode = "v",
    prefix = "<leader>l",
    name = "LSP and COC actions",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})
