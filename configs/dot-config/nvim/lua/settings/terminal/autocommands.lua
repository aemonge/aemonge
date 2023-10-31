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
        vim.api.nvim_set_option('laststatus', 2)
    end,
})

-- When only the term tab remains, clear all. To give the impression of closing vim.
vim.api.nvim_create_autocmd("TermEnter", {
    callback = function()
        if vim.fn.tabpagenr("$") == 1 then
            vim.cmd([[silent! BWipeout! hidden]])
            -- vim.cmd([[silent! lua ClearTerm()]])
        end
    end,
})


-- Close terminal buffer if exit 0; and close the unnamed unlisted buffer to exit all
-- vim.cmd([[autocmd TermClose * if !v:event.status | exe 'silent! bdelete! '..expand('<abuf>') | endif]])
vim.api.nvim_create_autocmd({ "TermClose" }, {
    callback = function()
        vim.cmd([[if !v:event.status | exe 'silent! bdelete! '..expand('<abuf>') | endif]])
        -- if not vim.v.event.status then
        --     vim.api.nvim_buf_delete(tonumber(vim.fn.expand('<abuf>')), { force = true })
        -- end

        if vim.fn.bufname('%') == '' then
            vim.api.nvim_command('q')
        end
    end
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
        vim.opt_local.bufhidden = "wipe"
        vim.opt_local.laststatus = 0
        vim.cmd([[ setlocal ft=terminal ]])

        -- Check if buffer name contains 'chatd'
        if not bufname:match("chatd") then
            vim.cmd([[ au BufEnter <buffer> :startinsert ]])
        end
        vim.cmd([[ au BufEnter <buffer> :set laststatus=0 ]])
    end,
})
