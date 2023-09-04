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

        local chat_ui = require("settings.bots.chatgpt-miu")

        require("which-key").register({
            name = "Chat with ...",
            c = { require("tabnine.chat").open, "tabnine" },
            g = { function() chat_ui(0) end, "ChatGPT" },
            G = { function() chat_ui(1) end, "ChatGPT" }
        }, {
            mode = { "n" },
            prefix = "<leader>c",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end
})

return M