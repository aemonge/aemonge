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

local M = {
    ["<c-w>"] = {
        name = "Split and Resize",

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

    ["<c-h>"] = { "<c-w><Left>", "Go left" },
    ["<c-l>"] = { "<c-w><Right>", "Go right" },

    ["<c-t>"] = { ":lua NewTermTab()<cr>", "New term tab" },

    ["<c-k>"] = {
        [''] = { "<c-w><Up>", "Go up" },
        ["<c-k>"] = { "gt", "Next tab" },
    },

    ["<c-j>"] = {
        [''] = { "<c-w><Down>", "Go down" },
        ["<c-j>"] = { "gT", "Previous tab" },
    },


    ['_'] = { ":resize -2<cr>", "Decrease Horizontally" },
    ['+'] = { ":resize +3<cr>", "Increase Horizontally" },
    ['='] = { ":vertical resize -2<cr>", "Decrease Vertically" },
    ['-'] = { ":vertical resize +3<cr>", "Increase Vertically" }
}
return M
