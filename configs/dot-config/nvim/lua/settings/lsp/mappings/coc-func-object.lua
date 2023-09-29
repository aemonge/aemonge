local wk = require("which-key")

wk.register({
    ["if"] = { "<Plug>(coc-funcobj-i)" },
    ["af"] = { "<Plug>(coc-funcobj-a)" },
    ["ic"] = { "<Plug>(coc-classobj-i)" },
    ["ac"] = { "<Plug>(coc-classobj-a)" }
}, {
    mode = { "x", "o" },
    silent = true,
    nowait = true,
    expr = true
})
