local M = {}

table.insert(M, {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    config = function()
        require("venv-selector").setup({
            dap_enabled = true,
            anaconda_envs_path = "~/.conda/envs"
        })
    end
})

return M
