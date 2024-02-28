local M = {
    "aemonge/llm.nvim",
    ft = require("file-types")({
        "languages",
        "frameworks",
        "markup"
    }),
    opts = {
        accept_keymap = "<C-l>",
        dismiss_keymap = "<C-c>",
        map_insert = true,
        tokens_to_clear = { "<|endoftext|>" },
        fim = {
            enabled = true,
            prefix = "<fim-prefix>",
            middle = "<fim-middle>",
            suffix = "<fim-suffix>",
        },
        model = "bigcode/santacoder",
        context_window = 8192,
        enable_suggestions_on_startup = true,
        enable_suggestions_on_files = require("file-types")({ "langExtensions" }),
        tokenizer = {
            repository = "bigcode/santacoder",
        },
    },
    keys = {
        { '<C-a>', '<Cmd>LLMSuggestion<CR>', { noremap = true, silent = true }, mode = "i" }
    }
}

return M
