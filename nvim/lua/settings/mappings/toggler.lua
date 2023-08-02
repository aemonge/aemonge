local M = {}

table.insert(M, {
  t = {
        name = "Toggler",
        e = {":setlocal foldenable!<cr>", "Fold"},
        w = {":setlocal wrap!<cr>", "Wrap"},
        h = {":set nohlsearch!<cr>", "Search highlight"},
        t = { ":call CocAction('diagnosticList')<cr>", "Show diagnostic list" },
        k = { [[:let @/ ='󱌌'<cr>]], " Clear search 󱌌 " }
    }
})

return M
