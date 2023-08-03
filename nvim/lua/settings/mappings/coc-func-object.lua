local M = {}

M.map = {
    ["if"] = { "<Plug>(coc-funcobj-i)" },
    ["af"] = { "<Plug>(coc-funcobj-a)" },
    ["ic"] = { "<Plug>(coc-classobj-i)" },
    ["ac"] = { "<Plug>(coc-classobj-a)" }
}

M.opts = {
    silent = true,
    nowait = true,
    expr = true,
    mode = { "x", "o" }
}

return M
