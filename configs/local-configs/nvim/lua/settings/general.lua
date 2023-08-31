vim.opt.autochdir = false -- Don't Change directory on file
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.autoread = true   -- Set autoread when a file is changed outside
vim.opt.autowrite = true  -- FileChangedShell * echo Warning: File changed on disk
vim.opt.backup = false    -- creates a backup file
vim.opt.clipboard = {     -- allows neovim to access the system clipboard
  "unnamed", "unnamedplus"
}
vim.opt.cmdheight = 0                 -- Hyper focused, hidden cmd bar
vim.opt.concealcursor = "v"           -- Mostly invisible, but when acting on it `vi` display it
vim.opt.conceallevel = 0              -- so that `` is visible in markdown files
vim.opt.conceallevel = 1              -- When text is marked as rich text “hidden characters”
vim.opt.cursorcolumn = true           -- Display vertical and horizontal current line
vim.opt.cursorline = true             -- Display vertical and horizontal current line
vim.opt.cursorline = true             -- highlight the current line
vim.opt.equalalways = false           -- Not set the split to equal sizes
vim.opt.errorbells = false            -- No sound on errors
vim.opt.expandtab = true              -- convert tabs to spaces
vim.opt.foldenable = true             -- More than often I want to start with things folded
vim.opt.foldlevel = 99                -- Support for nvim-ufo
vim.opt.foldlevelstart = 99           -- Support for nvim-ufo
vim.opt.hidden = true                 -- Keep buffers alive and hidden, until wipe out
vim.opt.history = 10000               -- Increase the lines of history
vim.opt.hlsearch = true               -- highlight all matches on previous search pattern
vim.opt.ignorecase = true             -- ignore case in search patterns
vim.opt.iskeyword.append = "-"        -- Make - case act as a-word
vim.opt.list = true                   -- Show these tabs and spaces and so on
vim.opt.matchtime = 2                 -- Decrease the time to blink
vim.opt.modeline = true               -- Turn on mode-line
vim.opt.mouse = ''                    -- Mouse can click over buffers, but just that.
vim.opt.mousehide = true              -- hide while typing
vim.opt.number = true                 -- Show the current line number ;)
vim.opt.numberwidth = 2               -- set number column width to 2 {default 4}
vim.opt.pumheight = 10                -- pop up menu height
vim.opt.relativenumber = true         -- Show line numbers relative
vim.opt.scrolloff = 2                 -- Avoid having a weird padding while moving with L H
vim.opt.shiftwidth = 2                -- the number of spaces inserted for each indentation
vim.opt.showmatch = true              -- Show matching brackets/parenthesis
vim.opt.showmode = false              -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2               -- always show tabs
vim.opt.sidescroll = 1                -- Minimal number of columns to scroll horizontally
vim.opt.sidescrolloff = 8             -- Minimal number of columns to scroll horizontally
vim.opt.signcolumn = "yes"            -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true              -- smart case
vim.opt.smartindent = false           -- Just keep the indentation form previous line, smart is dumb
vim.opt.splitbelow = true             -- force all horizontal splits to go below current window
vim.opt.splitright = true             -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false              -- Don't use a .~ swap file
vim.opt.tabstop = 4                   -- insert 2 spaces for a tab
vim.opt.termguicolors = true          -- set term gui colors (most terminals support this)
vim.opt.textwidth = 0                 -- Don't use the textwidth relay on overlength to display the warning
vim.opt.timeoutlen = 180              -- Time to wait for a command
vim.opt.title = true                  -- Set title
vim.opt.undofile = true               -- Use a directory to save undos
vim.opt.undoreload = 10000            -- maximum number lines to save for undo on a buffer reload
vim.opt.updatetime = 250              -- faster completion (4000ms default)
vim.opt.visualbell = false            -- No sound on errors
vim.opt.whichwrap = "<,>,[,],b,h,l,s" -- Allow specified keys that move the cursor left/right
vim.opt.wildignorecase = true         -- As it reads, ignoring case on wild menu, be like bash
vim.opt.wrap = true                   -- keep inits easy to read
vim.opt.writebackup = false           -- if a file is being edited by another program, it is not allowed to be e
vim.opt.linebreak = false             -- Don't break my lines, just warn me with over-length
vim.opt.incsearch = true
vim.opt.gdefault = true               -- Make the `s/` have the 'g' flag as default.

vim.g.markdown_fenced_languages = { 'html', 'python', 'ruby', 'vim', 'python', 'bash', 'javascript' }

-- My own file types
vim.cmd('filetype plugin on')

-- Spelling

-- Set custom directory for the spellfile
vim.opt.runtimepath:append("~/.config/nvim/spell")
vim.opt.spell = true -- Activate spelling
vim.opt.spelllang = { "es_es", "en_us" }
