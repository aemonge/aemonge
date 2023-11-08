local M = {}

M.M = {
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)<cr>", "Comment" },
  a = { "<Plug>(EasyAlign)*", "Align" },
  A = { "<Plug>(LiveEasyAlign)*", "Live Align (<c-p> to accept)" },
  f = { "<Plug>(coc-format-selected)", "Format" },
}

M.O = {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

return M
