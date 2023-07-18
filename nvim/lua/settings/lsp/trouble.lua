local M = {}

table.insert(M, {
  "folke/trouble.nvim",
  ft = require("file-types")({
    "markup",
    "languages",
    "frameworks",
  }),
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("trouble").setup({
      position = "bottom",           -- position of the list can be: bottom, top, left, right
      height = 40,
      width = 40,                    -- width of the list when position is left or right
      mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      group = true,                  -- group results by file
      padding = true,                -- add an extra new line on top of the list
      action_keys = {
        jump = { "<cr>" },           -- jump to the diagnostic or open / close folds
        toggle_mode = "M",           -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = nil,        -- toggle auto_preview
        hover = "K",                 -- opens a small popup with the full multiline message
        preview = nil,               -- preview the diagnostic location
        previous = "p",              -- previous item
        next = "n",                  -- next item
      },
      indent_lines = true,           -- add an indent guide below the fold icons
      auto_open = false,             -- automatically open the list when you have diagnostics
      auto_close = false,            -- automatically close the list when you have no diagnostics
      auto_preview = false,          -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false,             -- automatically fold a file trouble list at creation
    })

    local wk = require "which-key"
    wk.register({
      tt = { "<cmd>TroubleToggle<cr>", "Trouble" },
    }, {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    })
  end,
})

return M
