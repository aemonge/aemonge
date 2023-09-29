local M = {}

M.M = {
    ["<c-p>"] = { ":Telescope find_files <cr>", "Files search in CWD" },
    ["<c-n>"] = {
        ":Telescope buffers sort_mru=1 ignore_current_buffer=1 initial_mode=insert <cr>",
        "Buffer list",
    },
    ["<c-f>"] = { ":Telescope live_grep <cr>", "Grep on files in CWD" },
    ["<leader>f"] = {
        "Telescope",
        a = { "<cmd>Telescope <CR>", "Built-in" },
        h = { "<cmd>Telescope help_tags <CR>", "Help" },
        u = { "<cmd>Telescope undo <CR>", "Undo" },
        t = { "<cmd>Telescope tags <CR>", "Tags" },
        e = { "<cmd>Telescope emoji <CR>", "Emoji" },
        g = { "<cmd>Telescope glyph <CR>", "Glyph" },
    },
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
