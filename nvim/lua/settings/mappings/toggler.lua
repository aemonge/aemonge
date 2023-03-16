local M = {}

table.insert(M, {
  t = {
    name = "Toggler",
    e = {":setlocal foldenable!<cr>", "Fold"},
    w = {":setlocal wrap!<cr>", "Wrap"},
    -- t = {":TroubleToggle document_diagnostics<cr>", "Trouble diagnostics"},
    -- p = {":TodoLocList<cr>", "Todo location list"},
    h = {":set nohlsearch!<cr>", "Search highlight"},
    k = { [[:let @/ ='󱌌'<cr>]], " Clear search 󱌌 " },
    -- l = {":Limelight!!<cr>", "Limelight"},
  },
})

return M
