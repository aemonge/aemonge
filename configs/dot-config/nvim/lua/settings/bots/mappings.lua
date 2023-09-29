local mappings, options = {}, {}
local chat_ui = require("settings.bots.chatgpt-miu")

table.insert(mappings, {
    name = "AI Tools",
    t = { require("tabnine.chat").open, "Tabnine chat" },
    m = { function() chat_ui(1) end, "My ChatGPT" },
    n = { ":NeoAIToggle<cr>", "NeoAI" },
    N = { ":NeoAIContext<cr>", "NeoAI with context" }
})
table.insert(options, {
    mode = { "n" },
    prefix = "<leader>i",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})

return mappings, options
