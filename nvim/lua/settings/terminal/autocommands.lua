---------------------------------------------------------------------------
-- [neovim-remote](nvr): Close on Git Commit messages
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "gitrebase", "gitcommit", "diff" },
  command = "setlocal bufhidden=wipe"
})

vim.api.nvim_create_autocmd("TermLeave", {
  callback = function ()
    vim.cmd("set laststatus=2")
  end
})

vim.api.nvim_create_autocmd("TermEnter", {
  callback = function ()
    vim.cmd("set laststatus=0")
  end
})

vim.api.nvim_create_autocmd("TermEnter", {
  callback = function ()
    -- NOTE: when only the term tab remains, clear all. To give the impression of closing vim.
    if vim.fn.tabpagenr('$') == 1 then
      vim.cmd [[silent! BWipeout! other]]
    end
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  command = "if len(getbufinfo({'buflisted':1})) == 1 | qall | endif"
})

vim.api.nvim_create_autocmd({"TermOpen"}, {
  callback = function ()
    vim.opt_local.title = true
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.showcmd = false
    vim.opt_local.wrap = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldenable = false
    vim.opt_local.spell = false
    vim.opt_local.ruler = false
    vim.cmd [[
      setlocal ft=terminal
      au BufEnter <buffer> :startinsert
    ]]
  end
})
