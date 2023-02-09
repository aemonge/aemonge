---------------------------------------------------------------------------
-- [neovim-remote](nvr): Close on Git Commit messages
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "gitrebase", "gitcommit", "diff" },
  command = "setlocal bufhidden=wipe"
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
      au BufEnter <buffer> :set laststatus=0
      au BufLeave <buffer> :set laststatus=3
    ]]
    -- laststatus is to hide the Lua line
  end
})

