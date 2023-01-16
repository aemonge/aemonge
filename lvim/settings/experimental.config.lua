--------------------------------------------------------------------------------------------------------------------------
--                                                      Experimental                                                     |
--------------------------------------------------------------------------------------------------------------------------
-- table.insert(lvim.plugins, { "hrsh7th/nvim-pasta", -- Not working with lsp syntax.
--   init = function ()
--     vim.keymap.set({ 'n', 'x' }, 'p', require('pasta.mappings').p)
--     vim.keymap.set({ 'n', 'x' }, 'P', require('pasta.mappings').P)
--   end
-- })

-- TODO: Own this repo, to toggle the stack with the same command and to add the option to open in the middle of the screen
-- table.insert(lvim.plugins, { "RishabhRD/popfix" }) -> To center in a popup the Scratch
table.insert(lvim.plugins, { 'mtth/scratch.vim',
  dependencies = "folke/which-key.nvim",
  config = function ()
    vim.g.scratch_no_mappings = 1
    vim.g.scratch_height = 25
    vim.g.scratch_top = 0

    require "which-key".register({
      ['<C-s>'] = { "<esc>:ScratchInsert<cr>", "Open Scratch Pad"},
    }, { mode = "i", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,})
    require "which-key".register({
      ['<C-s>'] = { ":Scratch<cr>", "Open Scratch Pad"},
    }, { mode = { "n", "t" }, prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,})
    require "which-key".register({
      ['<C-s>'] = { ":ScratchSelection<cr>", "Open Scratch Pad"},
    }, { mode = "v", prefix = nil, buffer = nil, silent = true, noremap = true, nowait = true,})
    vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
      pattern = "scratch",
      callback = function ()
        vim.keymap.set({ 'n', 'i' }, '<c-s>', '<esc><C-w>w', { buffer = true, silent = true, noremap = true, nowait = true})
      end
    })

  end
})

-- TODO: test: https://github.com/ggVGc/vim-fuzzysearch
-- https://github.com/gelguy/wilder.nvim -- NOT Worth it , too old

--------------------------------------------------------
-- Terminal Lvim Toggle Term default seams nice bro
-------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
--                                                      Bug/Erroneous                                                    |
--------------------------------------------------------------------------------------------------------------------------
-- table.insert(lvim.plugins, { "jaxbot/selective-undo.vim" })
-- table.insert(lvim.plugins, { "RishabhRD/nvim-lsputils" })

---------------------------------------------------------------------------
-- Markdown
---------------------------------------------------------------------------
-- Markdown Conceal and Rich text
-- BUG: Doesn't folds
-- table.insert(lvim.plugins, { "prurigro/vim-markdown-concealed" }) -- # NOTE: The best so far, but not good enough.
-- table.insert(lvim.plugins, { "jakewvincent/mkdnflow.nvim",
--     rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
--     config = function() require('mkdnflow').setup({}) end
-- })
-- table.insert(lvim.plugins, { "vim-scripts/Txtfmt-The-Vim-Highlighter" })
-- table.insert(lvim.plugins, { "preservim/vim-markdown", }) # NOTE: Simply break working with markdown
-- vim.g.vim_markdown_conceal = 0
-- vim.g.vim_markdown_math = 1
