---------------------------------------------------------------------------
--  Split Resize
---------------------------------------------------------------------------
local M = {
  ["<c-w>"] = {
    name = "Split and Resize",

    h = { ":leftabove vsplit<cr>" , "Split left"},
    j = { ":rightbelow split<cr>", "Split down" },
    k = { ":leftabove split<cr>", "Split up" },
    l = { ":rightbelow vsplit<cr>", "Split Right" },

    d = { ":tabc<cr>", "Tab Close" },

    O = { ":BWipeout! other<CR>", "Close all other buffers" },

    n = { ":+tabmove <CR>" , "Move tab to next"},
    p = { ":-tabmove <CR>" , "Move tab to previous"},
    ['9'] = { ":tabmove <CR>" , "Move tab to Last"},
    ['0'] = { ":0tabmove <CR>" , "Move tab to first"},

    s = nil,
    v = nil,
  },

  ["<c-h>"] = { "<c-w><Left>" , "Go left"},
  ["<c-j>"] = { "<c-w><Down>" , "Go down"},
  ["<c-k>"] = { "<c-w><Up>" , "Go up"},
  ["<c-l>"] = { "<c-w><Right>" , "Go right"},

  ["<c-j><c-j>"] = { "gT" , "Previous tab"},
  ["<c-k><c-k>"] = { "gt" , "Next tab"},

  ['_'] = { ":resize -2<cr>", "Decrease Horizontally" },
  ['+'] = { ":resize +3<cr>" , "Increase Horizontally"},
  ['='] = { ":vertical resize -2<cr>" , "Decrease Vertically"},
  ['-'] = { ":vertical resize +3<cr>" , "Increase Vertically"}
}
return M
