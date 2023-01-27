vim.opt.history = 1000     -- Increase the lines of history
vim.opt.undofile = true    -- Use a directory to save undos
vim.opt.undolevels = 10000 -- maximum number of changes that can be undone
vim.opt.undoreload = 10000 -- maximum number lines to save for undo on a buffer reload

vim.opt.concealcursor = "v"
vim.opt.conceallevel = 1     -- When text is marked as rich text “hidden characters”
vim.opt.cursorcolumn = true  -- Display vertical and horizontal current line
vim.opt.cursorline = true    -- Display vertical and horizontal current line
vim.opt.foldenable = false   -- keep inits easy to read
vim.opt.linebreak = false    -- Wrap long lines at a blank
vim.opt.list = true          -- Show these tabs and spaces and so on
vim.opt.matchtime = 2        -- Decrease the time to blink
vim.opt.scrolloff = 0        -- Avoid having a weird padding while moving with L H
vim.opt.showmatch = true     -- Show matching brackets/parenthesis
vim.opt.sidescroll = 1       -- Minimal number of columns to scroll horizontally
vim.opt.textwidth = 0        -- Don't use the textwidth relay on overlength to display the warning
vim.opt.title = true         -- Set title
vim.opt.wrap = true          -- keep inits easy to read
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.equalalways = false -- Not set the split to equal sizes

vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full" -- Truly like bash
vim.opt.completeopt = "longest,menuone,noselect,preview"

vim.opt.autochdir = false         -- Change directory on file
vim.opt.autoread = true           -- Set autoread when a file is changed outside
vim.opt.autowrite = true          -- Write on make/shell commands au FileChangedShell * echo Warning: File changed on disk
vim.opt.errorbells = false        -- No sound on errors
vim.opt.exrc = true               -- Execute .vimrc file under current folders ;)
vim.opt.foldenable = true         -- More than often I want to start with things folded
vim.opt.hidden = true             -- Turn on hidden
vim.opt.modeline = true           -- Turn on modeline
vim.opt.mouse = "a"               -- Mouse can click over buffers, but just that.
vim.opt.mousehide = true          -- hide while typing
vim.opt.number = true             -- Show the current line number ;)
vim.opt.relativenumber = true     -- Show line numbers relative
vim.opt.secure = true             -- Just run .vimrc file that the owner is `whoami`
vim.opt.swapfile = false          -- Don't use a .~ swap file
vim.opt.timeoutlen = 180          -- Time to wait for a command
vim.opt.visualbell = false        -- No sound on errors
vim.opt.clipboard = 'unnamedplus' -- Share clipboard with the OS
vim.opt.signcolumn = 'no'         -- It's enough with the colored number, no need to have signos on  my face
vim.opt.spell = true
vim.opt_global.spelllang = "en,es"

  vim.opt_local.scrollback = 1
  vim.opt_local.scrollback = 10000
  vim.opt_local.title = true
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.showcmd = false
  vim.opt_local.wrap = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldenable = false
  vim.opt_local.spell = false
  vim.opt_local.ruler = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.numberwidth  = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
