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
        tokens_to_clear = { "<EOT>" },
        fim = {
            enabled = true,
            prefix = "<PRE> ",
            middle = " <MID>",
            suffix = " <SUF>",
        },
        -- model = "WizardLM/WizardCoder-3B-V1.0",
        -- model = "https://api-inference.huggingface.co/models/WizardLM/WizardCoder-Python-7B-V1.0",
        -- model = "TinyLlama/TinyLlama-1.1B-python-v0.1",  -- To be tested
        -- model = "mlx-llama/CodeLlama-7b-Python-mlx",     -- To be tested
        -- model = "https://api-inference.huggingface.co/models/WizardLM/WizardCoder-Python-34B-V1.0",  -- UnTested and Expensive
        -- model = "https://aemonge-wizardlm-wizardcoder-python-34b-v1-0.hf.space/--replicas/cepi0/",
        -- model = "https://aemonge-cognitivecomputations-dolphin-2-5-mixtral-8x7b.hf.space/--replicas/83syr/",
        -- model = "aemonge/cognitivecomputations-dolphin-2.5-mixtral-8x7b",
        -- model = "bigcode/starcoder",  -- Works
        model = "codellama/CodeLlama-13b-hf", -- Works
        context_window = 16384,
        enable_suggestions_on_startup = true,
        enable_suggestions_on_files = require("file-types")({ "langExtensions" }),
        tokenizer = {
            -- repository = "bigcode/starcoder",
            repository = "codellama/CodeLlama-13b-hf",
        },
    },
    keys = {
        { '<C-a>', '<Cmd>LLMSuggestion<CR>', { noremap = true, silent = true }, mode = "i" }
    }
}

return M
