vim.api.nvim_create_augroup("BufferMd", {})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = "BufferMd",
    desc = "Read eternally from buffer, and interpret as markdown",
    callback = function()
        vim.cmd [[
            setlocal readonly
            setlocal autoread
            setlocal filetype=markdown
            ToggleTailBuffer
        ]]
    end
})
