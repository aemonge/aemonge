vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function()
        require('swenv.api').auto_venv()
    end
})