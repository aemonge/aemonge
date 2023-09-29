---------------------------------------------------------------------------
-- [neovim-remote](nvr): Close on Git Commit messages
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = require("file-types")({ "versionControl" }),
    command = "setlocal bufhidden=wipe",
})

vim.api.nvim_create_autocmd("TermLeave", {
    callback = function()
        if pcall(require, "tint") then
            require("tint").untint(vim.api.nvim_get_current_win())
        end
        vim.cmd("set laststatus=2")
    end,
})

vim.api.nvim_create_autocmd("TermEnter", {
    callback = function()
        vim.cmd("set laststatus=0")
    end,
})

vim.api.nvim_create_autocmd("TermEnter", {
    callback = function()
        -- NOTE: when only the term tab remains, clear all.
        --       To give the impression of closing vim.
        if vim.fn.tabpagenr("$") == 1 then
            vim.cmd([[silent! BWipeout! hidden]])
        end
    end,
})

vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
        local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
        if #listed_buffers == 1 then
            vim.cmd("qall")
        else
            vim.cmd("q")
        end
    end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    callback = function()
        local bufname = vim.fn.bufname("%")
        vim.opt_local.title = true
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.showcmd = false
        vim.opt_local.wrap = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.foldenable = false
        vim.opt_local.spell = false
        vim.opt_local.ruler = false
        vim.opt_local.buflisted = false
        vim.cmd([[
            setlocal ft=terminal
            setlocal bufhidden=delete
        ]])

        -- Check if buffer name contains 'chatd'
        if not bufname:match("chatd") then
            vim.cmd([[ au BufEnter <buffer> :startinsert ]])
        end
    end,
})
