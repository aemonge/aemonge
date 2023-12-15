local M = {
    "dustinblackman/oatmeal.nvim",
    cmd = { "Oatmeal" },
    keys = {
        { "<leader>m", mode = "n", desc = "Start Oatmeal session" },
    },
    opts = {
        backend = "ollama",
        model = "codellama:latest",
    },

}

return M
