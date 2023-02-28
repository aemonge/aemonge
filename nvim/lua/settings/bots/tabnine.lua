local M = {}

table.insert(M, { "tzachar/cmp-tabnine",
  build = "./install.sh",
  dependencies = "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  config = function()
    require('cmp_tabnine.config'):setup({
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = '...',
      show_prediction_strength = true
    })
    require'cmp'.setup {
     sources = {
      { name = "cmp_tabnine",
        priority = 100,
        keyword_length = 3,
        max_item_count = 5,
      }
     },
    }
  end
})

return M
