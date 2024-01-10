local M = {}

table.insert(M, {
    "stevearc/dressing.nvim",
    opts = {
        input = {
            enabled = true,
            prompt_align = "center",
            insert_only = false,
            start_in_insert = true,
            relative = "editor",
            prefer_width = 0.7,
            win_options = {
                winblend = 15,
                wrap = true,
            },
            mappings = {
                n = {
                    ["<Esc>"] = "Close",
                    ["<c-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                    ["<c-k>"] = "Confirm",
                },
                i = {
                    ["<c-c>"] = "Close",
                    ["<c-k>"] = "Confirm",
                    ["<CR>"] = "Confirm",
                    ["<c-p>"] = "HistoryPrev",
                    ["<c-n>"] = "HistoryNext",
                },
            },
        },
        nui = {
            win_options = {
                winblend = 15,
            }
        },
        select = {
            builtin = {
                mappings = {
                    ["<Esc>"] = "Close",
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                    ["<c-k>"] = "Confirm",
                }
            },
            backend = { "telescope", "fzf_lua", "fzf", "nui", "builtin" },
        }
    }
})

return M
