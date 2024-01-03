---------------------------------------------------------------------------
--  Split Resize
---------------------------------------------------------------------------
vim.cmd [[
function! CloseTabOrQuit()
    " Try to close the current tab
    try
        :tabclose
    catch /^Vim(\a\+):E784:/
        " If it fails, quit all
        :qa!
    endtry
endfunction
]]

local M = {}
M.M = {
    ["<c-w>"] = {
        name = "  Split, move or re-size",

        h = { ":leftabove vsplit<cr>", "Split left" },
        j = { ":rightbelow split<cr>", "Split down" },
        k = { ":leftabove split<cr>", "Split up" },
        l = { ":rightbelow vsplit<cr>", "Split right" },

        t = { ":rightbelow split  | terminal<cr>", "Toggle horizontal term" },
        T = { ":rightbelow vsplit | terminal<cr>", "Toggle vertical term" },

        d = { ":call CloseTabOrQuit()<cr>", "Tab close or quit" },

        O = { ":BWipeout! other<CR>", "Close all other buffers" },

        n = { ":+tabmove <CR>", "Move tab to next" },
        p = { ":-tabmove <CR>", "Move tab to previous" },
        ['9'] = { ":tabmove <CR>", "Move tab to Last" },
        ['0'] = { ":0tabmove <CR>", "Move tab to first" },

        s = nil,
        v = nil,
    },

    ["<c-j>"] = {
        [""] = { "<c-w>W", "Previous window" },
        ["<c-j>"] = { "gT", "Previous tab" },
    },
    ["<c-k>"] = {
        [""] = { "<c-w>w", "Next window" },
        ["<c-k>"] = { "gt", "Next tab" },
    },

    ["<c-t>"] = { ":lua NewTermTab()<cr>", "New term tab" },

    ['_'] = { ":resize -2<cr>", "Decrease Horizontally" },
    ['+'] = { ":resize +3<cr>", "Increase Horizontally" },
    ['='] = { ":vertical resize -2<cr>", "Decrease Vertically" },
    ['-'] = { ":vertical resize +3<cr>", "Increase Vertically" },
}

M.O = {
    mode = "n",
    prefix = nil,
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}
return M
