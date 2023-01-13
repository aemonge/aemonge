--------------------------------------------------------------------------------------------------------------------------
--                                                General Settings                                                       |
--------------------------------------------------------------------------------------------------------------------------
vim.opt.autochdir = false         -- Change directory on file
vim.opt.autoread = true           -- Set autoread when a file is changed outside
vim.opt.autowrite = true          -- Write on make/shell commands au FileChangedShell * echo Warning: File changed on disk
vim.opt.errorbells = false        -- No sound on errors
vim.opt.exrc = true               -- Execute .vimrc file under current folders ;)
vim.opt.hidden = true             -- Turn on hidden
vim.opt.modeline = true           -- Turn on modeline
vim.opt.mouse = "a"               -- Mouse can click over buffers, but just that.
vim.opt.mousehide = true          -- hide while typing
vim.opt.number = true             -- Show the current line number ;)
vim.opt.relativenumber = true     -- Show line numbers relative
vim.opt.secure = true             -- Just run .vimrc file that the owner is `whoami`
vim.opt.swapfile = false          -- Don't use a .~ swap file
vim.opt.timeoutlen = 250          -- Time to wait for a command
vim.opt.visualbell = false        -- No sound on errors
vim.opt.clipboard = 'unnamedplus' -- Share clipboard with the OS

---------------------------------------------------------------------------
--  Common mistakes, remaps
---------------------------------------------------------------------------
lvim.keys.normal_mode["q;"] = "q:" -- vim.keymap.set('n', 'q;', 'q:', { silent = true })
lvim.keys.insert_mode["<c-d>"] = "<esc>:q!<cr>" -- vim.keymap.set('n', 'q;', 'q:', { silent = true })

---------------------------------------------------------------------------
--  Spelling                                                              |
---------------------------------------------------------------------------
vim.opt.spell = true
vim.opt_global.spelllang = "en,es"
table.insert(lvim.plugins, { "rhysd/vim-grammarous",
  ft = { "markdown", "html", "text", "tex" }
})

---------------------------------------------------------------------------
--  Lunar Vim Overwrites and Settings
---------------------------------------------------------------------------
lvim.reload_config_on_save = true
lvim.log.level = "off"
lvim.leader = ","
lvim.format_on_save = false
lvim.builtin.alpha.active = false
