local M = {}

table.insert(M, {
    "neovim/nvim-lspconfig",
    -- dependencies = { "wbthomason/packer.nvim", "neovim/nvim-lspconfig" },
    -- dependencies = { "neovim/nvim-lspconfig" },
    ft = require("file-types")({
        "languages",
        "frameworks",
    }),
    config = function()
        -- Mappings.
        local on_attach = function(_, bufnr)
            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        end

        local lsp_flags = {
            -- This is the default in Nvim 0.7+
            debounce_text_changes = 150,
        }
        require("lspconfig")["pyright"].setup({
            on_attach = on_attach,
            flags = lsp_flags,
        })
    end,
})

return M
