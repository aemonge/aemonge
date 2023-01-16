--------------------------------------------------------------------------------------------------------------------------
--                                                    Code Actions                                                       |
--------------------------------------------------------------------------------------------------------------------------
table.insert(lvim.plugins, { "tpope/vim-repeat" })

---------------------------------------------------------------------------
-- Format
---------------------------------------------------------------------------
require "lvim.lsp.null-ls.formatters".setup {
  { command = "prettier", filetypes = { "json", "javascript", "typescript", "typescriptreact", "html" } },
  { command = "yapf", filetypes = { "python" } },
}
table.insert(lvim.plugins, { "RRethy/nvim-align" })

---------------------------------------------------------------------------
-- Editors Configurations
---------------------------------------------------------------------------
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.numberwidth  = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
table.insert(lvim.plugins, { "gpanders/editorconfig.nvim" })

---------------------------------------------------------------------------
-- Project Specific Settings
---------------------------------------------------------------------------
-- lvim.builtin.project.scope_chdir = 'tab'
lvim.builtin.project.patterns = {
  ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "requirements.txt", "Gemfile", "environment.yml",
  "README.rst", "README.md", "pyproject.toml", "tox.ini"
}

---------------------------------------------------------------------------
-- Automatic Snippet like behavior
---------------------------------------------------------------------------
table.insert(lvim.plugins, { 'tpope/vim-surround' })
table.insert(lvim.plugins, { "bootleq/vim-cycle" })

vim.g.cycle_no_mappings = 1
vim.cmd [[ nmap <silent> <C-a> <Plug>CycleNext ]]
vim.cmd [[ vmap <silent> <C-x> <Plug>CyclePrev ]]
vim.cmd [[ noremap <silent> <Plug>CycleFallbackNext <C-A> ]]
vim.cmd [[ noremap <silent> <Plug>CycleFallbackPrev <C-X> ]]

vim.cmd [[ silent! call cycle#add_group([ 'set', 'get' ]) ]]
vim.cmd [[ silent! call cycle#add_group(['form', 'to']) ]]
vim.cmd [[ silent! call cycle#add_group(['push', 'pop']) ]]
vim.cmd [[ silent! call cycle#add_group(['more', 'less']) ]]
vim.cmd [[ silent! call cycle#add_group(['mas', 'menos']) ]]
vim.cmd [[ silent! call cycle#add_group(['prev', 'next']) ]]
vim.cmd [[ silent! call cycle#add_group(['start', 'end']) ]]
vim.cmd [[ silent! call cycle#add_group(['light', 'dark']) ]]
vim.cmd [[ silent! call cycle#add_group(['open', 'close']) ]]
vim.cmd [[ silent! call cycle#add_group(['read', 'write']) ]]
vim.cmd [[ silent! call cycle#add_group(['truthy', 'falsy']) ]]
vim.cmd [[ silent! call cycle#add_group(['weight', 'height']) ]]
vim.cmd [[ silent! call cycle#add_group(['filter', 'reject']) ]]
vim.cmd [[ silent! call cycle#add_group(['disable', 'enable']) ]]
vim.cmd [[ silent! call cycle#add_group(['const', 'let', 'var']) ]]
vim.cmd [[ silent! call cycle#add_group(['disabled', 'enabled']) ]]
vim.cmd [[ silent! call cycle#add_group(['internal', 'external']) ]]
vim.cmd [[ silent! call cycle#add_group(['floor', 'round', 'ceil']) ]]
vim.cmd [[ silent! call cycle#add_group(['subscribe', 'unsubscribe']) ]]
vim.cmd [[ silent! call cycle#add_group(['header', 'body', 'footer']) ]]
vim.cmd [[ silent! call cycle#add_group(['protected', 'private', 'public']) ]]
vim.cmd [[ silent! call cycle#add_group(['red', 'blue', 'green', 'yellow']) ]]
vim.cmd [[ silent! call cycle#add_group(['tiny', 'small', 'medium', 'big', 'huge']) ]]
vim.cmd [[ silent! call cycle#add_group(['debug', 'info', 'warn', 'error', 'silent']) ]]
vim.cmd [[ silent! call cycle#add_group(['x-short', 'short', 'normal', 'medium', 'long', 'large', 'x-large']) ]]
vim.cmd [[ silent! call cycle#add_group(['pico', 'nano', 'micro', 'mili', 'kilo', 'mega', 'giga', 'tera', 'peta']) ]]
vim.cmd [[ silent! call cycle#add_group(['sunday', 'monday', 'tuesday', 'wensday', 'thursday', 'friday', 'saturday']) ]]
