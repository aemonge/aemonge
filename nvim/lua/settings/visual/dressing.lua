local M = {}

table.insert(M, { "stevearc/dressing.nvim",
  config = function ()
    require('dressing').setup({
      input = {
        enabled = true,
        prompt_align = "center",
        insert_only = false,
        start_in_insert = false,
        relative = "editor",
        prefer_width = 0.4,
        win_options = {
          winblend = 15,
          wrap = true,
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<c-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<c-k>"] = "Confirm",
          },
          i = {
            ["<c-c>"] = "Close",
            ["<c-k>"] = "Confirm",
            ["<CR>"] = "Confirm",
            ["<c-p>"] = "HistoryPrev",
            ["<c-n>"] = "HistoryNext",
          },
        },
      },
      select = {
        builtin = {
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<c-k>"] = "Confirm",
          }
        }
      }
    })
  end
})

return M
