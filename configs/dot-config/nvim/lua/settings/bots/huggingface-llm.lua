local M = {
  "huggingface/llm.nvim",
  ft = require("file-types")({
    "languages",
    "frameworks",
    "markup"
  }),
  opts = {
    accept_keymap = "<C-l>",
    dismiss_keymap = "<C-c>",
    -- model = "wizardlm/WizardCoder-Python-34B-V1.0",
    -- model = "codellama/CodeLlama-7b-Python-hf",
    -- model = "https://api-inference.huggingface.co/models/WizardLM/WizardCoder-Python-34B-V1.0",
    model = "bigcode/starcoderplus",
    context_window = 16384,     -- 8192,
    tokenizer = {
      -- repository = "bigcode/starcoderplus",
      -- to = "/home/aemonge/usr/configs/unlinked/llama-tokenizer.json"
      -- path = "/home/aemonge/usr/configs/unlinked/wizard-tokenizer.json"
      path = "/home/aemonge/usr/configs/unlinked/llama-tokenizer.json"
    }
  }
}

return M
