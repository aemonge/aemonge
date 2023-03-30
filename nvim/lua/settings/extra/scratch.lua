local M = {
    "mtth/scratch.vim",
    dependencies = "folke/which-key.nvim",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
    }),
    config = function()
        vim.g.scratch_no_mappings = 1
        vim.g.scratch_height = 25
        vim.g.scratch_top = 0

        require("which-key").register(
            {
                ["<C-s>"] = { "<esc>:ScratchInsert<cr>", "Open Scratch Pad" },
            },
            {
                mode = "i",
                prefix = nil,
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            }
        )
        require("which-key").register(
            {
                ["<C-s>"] = { ":Scratch<cr>", "Open Scratch Pad" },
            },
            {
                mode = { "n", "t" },
                prefix = nil,
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            }
        )
        require("which-key").register(
            {
                ["<C-s>"] = { ":ScratchSelection<cr>", "Open Scratch Pad" },
            },
            {
                mode = "v",
                prefix = nil,
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            }
        )
        vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
            pattern = "scratch",
            callback = function()
                vim.keymap.set(
                    { "n", "i" },
                    "<c-s>",
                    "<esc><C-w>w",
                    {
                        buffer = true,
                        silent = true,
                        noremap = true,
                        nowait = true,
                    }
                )
            end,
        })
    end,
}

return M
