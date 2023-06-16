local M = {}

local function get_jedi_language_server_path()
    local handle = io.popen("which jedi-language-server")
    local result = handle:read("*a")
    handle:close()
    return result:match("^%s*(.-)%s*$")
end

table.insert(M, {
    "neovim/nvim-lspconfig",
    -- dependencies = { "wbthomason/packer.nvim", "neovim/nvim-lspconfig" },
    dependencies = { "neovim/nvim-lspconfig" },
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

        local jedi_path = get_jedi_language_server_path()
        if jedi_path then
            require("lspconfig")["jedi_language_server"].setup({
                cmd = { jedi_path },
                on_attach = on_attach,
                flags = lsp_flags,
            })
        end
    end,
})

return M
