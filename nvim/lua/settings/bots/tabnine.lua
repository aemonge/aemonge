local M = {}

table.insert(M, {
    'codota/tabnine-nvim',
    ft = require("file-types")({
        "languages",
        "frameworks",
        "markup"
    }),
    build = "./dl_binaries.sh",
    config = function()
        require('tabnine').setup({
            disable_auto_comment = true,
            accept_keymap = "<C-l>",
            dismiss_keymap = "<C-c>",
            debounce_ms = 300,
            suggestion_color = { gui = "#916690" }, -- #8787D7" }, -- color104
            exclude_filetypes = { "TelescopePrompt" }
        })

        require("which-key").register({
            name = "Chat with ...",
            c = { require("tabnine.chat").open, "tabnine"}
        }, {
          mode = {"n"},
          prefix = "<leader>c",
          buffer = nil,
          silent = true,
          noremap = true,
          nowait = true,
        })
    end
})

return M
