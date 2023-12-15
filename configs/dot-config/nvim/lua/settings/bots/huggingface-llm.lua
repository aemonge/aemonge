local M = {
  "huggingface/llm.nvim",
  ft = require("file-types")({
    "languages",
    "frameworks",
    "markup"
  }),
  opts = {
    accept_keymap = "<C-k>",
    dismiss_keymap = "<C-c>",
    -- tokens_to_clear = { "<|endoftext|>" },
    -- fim = {
    --     enabled = true,
    --     prefix = "<fim_prefix>",
    --     middle = "<fim_middle>",
    --     suffix = "<fim_suffix>",
    -- },
    model = "WizardLM/WizardCoder-3B-V1.0",
    -- model = "bigcode/starcoder",  -- Works
    -- model = "TinyLlama/TinyLlama-1.1B-python-v0.1",  -- To be tested
    -- model = "mlx-llama/CodeLlama-7b-Python-mlx",     -- To be tested
    -- model = "https://api-inference.huggingface.co/models/WizardLM/WizardCoder-Python-34B-V1.0",  -- UnTested and Expensive
    -- context_window = 8192, -- 16384 ,
    tokenizer = {
    --   repository = "bigcode/starcoder",
    --   -- to = "/home/aemonge/usr/configs/unlinked/llama-tokenizer.json"
      path = "/vault/models/WizardCoder/tokenizer.json"
    --   -- path = "/home/aemonge/usr/configs/unlinked/llama-tokenizer.json"
    }
  }
}

return M
