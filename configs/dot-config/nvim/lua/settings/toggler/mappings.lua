local M = {}

local _breakpoints = function()
    require 'dap'.list_breakpoints()
    vim.cmd [[copen]]
end

M.M = {
    t = {
        name = "Toggler",
        e = { ":setlocal foldenable!<cr>", "Fold" },
        w = { ":setlocal wrap!<cr>", "Wrap" },
        h = { ":set nohlsearch!<cr>", "Search highlight" },
        t = { ":call CocAction('diagnosticList')<cr>", "Show diagnostic list" },
        k = { [[:let @/ ='󱌌'<cr>]], " Clear search 󱌌 " },
        b = { function() _breakpoints() end, "Toggle Breakpoints" },
        B = { "<cmd>lua require'dap'.clear_breakpoints()<CR>", "Clear Breakpoints" },
        l = { ":Twilight<CR>", "Toggle Twilight" }
    }
}

M.O = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M, O
