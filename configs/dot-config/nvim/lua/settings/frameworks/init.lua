local M = {}


local swenv = require("settings.frameworks.swenv")
table.insert(M, swenv)

table.insert(M, {
    "leafOfTree/vim-svelte-plugin"
})

table.insert(M, { "plasticboy/vim-markdown" })

return M
