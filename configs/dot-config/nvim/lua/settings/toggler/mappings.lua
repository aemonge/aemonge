local M = {}

local _breakpoints = function()
    require 'dap'.list_breakpoints()
    vim.cmd [[copen]]
end

M.M = {
    a = { ":LLMToggleAutoSuggest <CR>", "Toggle LLM" },
    e = { ":setlocal foldenable!<cr>", "Fold" },
    w = { ":setlocal wrap!<cr>", "Wrap" },
    g = { ":Gitsigns toggle_current_line_blame<cr>", "Git blame" },
    h = { ":set nohlsearch!<cr>", "Search highlight" },
    t = { ":call CocAction('diagnosticList')<cr>", "Show diagnostic list" },
    k = { [[:let @/ ='󱌌'<cr>]], " Clear search " },
    b = { function() _breakpoints() end, "Toggle Breakpoints" },
    B = { "<cmd>lua require'dap'.clear_breakpoints()<CR>", "Clear Breakpoints" },
    l = { ":Twilight<CR>", "Toggle Twilight" },
    u = { ":UfoAttach<CR>", "Enable Ufo" },
    U = { ":UfoDetach<CR>", "Disable Ufo" },
}

M.O = {
    mode = "n",
    prefix = "<leader>t",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
