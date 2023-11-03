local M = {}

M.M = {
    name = "AI Tools",
    i = {
        t = { require("tabnine.chat").open, "Tabnine chat" },
        m = { function() require("settings.bots.chatgpt-miu")(1) end, "My ChatGPT" },
        n = { ":NeoAIToggle<cr>", "NeoAI" },
        N = { ":NeoAIContext<cr>", "NeoAI with context" }
    }
}

M.O = {
    mode = { "n", "v" },
    name = "AI Tools",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
