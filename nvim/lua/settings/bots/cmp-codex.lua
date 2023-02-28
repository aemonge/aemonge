local M = {}

table.insert(M, {
  "alpha2phi/cmp-openai-codex",
  config = function ()
    require'cmp'.setup {
      sources = {
        { name = "cmp_openai_codex",
          priority = 90,
          keyword_length = 3,
          max_item_count = 5,
        }
      }
     }
  end
})

return M
