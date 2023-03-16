local M = {}

table.insert(M, {
  "alpha2phi/cmp-openai-codex",
  event = "InsertEnter",
  dependencies = "hrsh7th/nvim-cmp"
})

return M
