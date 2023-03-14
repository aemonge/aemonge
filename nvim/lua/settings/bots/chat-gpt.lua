local M = {}

table.insert(M, {
  "jackMort/ChatGPT.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function()
    require("chatgpt").setup( {
      keymaps = {
        close = { "<Esc><Esc>" },
        submit = "<c-k>",
        yank_last = "<c-y>",
        scroll_up = "<c-u>",
        scroll_down = "<c-d>",
        toggle_settings = "<C-o>",
        new_session = "<n-n>",
        cycle_windows = "<c-p>",
        -- in the Sessions pane
        select_session = "<CR>",
        rename_session = "r",
        delete_session = "d",
      }
    })
    require "which-key".register({
      c = {
        name = "ChatGPT",
        o = { [[:ChatGPTCompleteCode<cr>]], "Complete Code" },
        c = { [[:ChatGPT<cr>]], "Chat" },
        a = { [[:ChatGPTActAs<cr>]], "Act as .." }
      }
    }, {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    })
  end
})

return M
