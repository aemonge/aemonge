--------------------------------------------------------------------------------------------------------------------------
--                                                      Frameworks                                                       |
--------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------
-- Python (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
---------------------------------------------------------------------------
require'lspconfig'.jedi_language_server.setup{}
-- require'lspconfig'.pyright.setup{}

---------------------------------------------------------------------------
-- Rails
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "tpope/vim-rbenv",
  ft = "ruby"
})
table.insert(lvim.plugins, { "tpope/vim-rails",
  ft = "ruby"
})

---------------------------------------------------------------------------
-- Jupiter [vim-jukit](https://github.com/luk400/vim-jukit)
---------------------------------------------------------------------------
-- table.insert(lvim.plugins, { "luk400/vim-jukit",
--   ft = "python",
--   config = function ()
--     vim.g.jukit_mappings = 0
--     vim.g.jukit_convert_overwrite_default = 1
--     vim.g.jukit_convert_open_default = 0

--     -- Jupiter Notebooks - iPython AI Statistics Libraries
--     table.insert(lvim.builtin.which_key.mappings["p"], {
--       j = {
--         ":call jukit#convert#notebook_convert(\"jupyter-notebook\")<cr>",
--         "Jupiter Convert"
--       },
--       J = {
--         ":autocmd! BufWritePost <buffer> call jukit#convert#notebook_convert(\"jupyter-notebook\")<cr>",
--         "Jupiter Auto-Convert"
--       }
--     })

--     lvim.builtin.which_key.mappings["c"] = {
--       name = "+JupiterCells",
--       o = { ":call jukit#cells#create_below(0)<cr>", "Create Below" },
--       O = { ":call jukit#cells#create_above(0)<cr>", "Create Above" },
--       t = { ":call jukit#cells#create_below(1)<cr>", "Create Text Below" },
--       T = { ":call jukit#cells#create_above(1)<cr>", "Create Text Above" },
--       d = { ":call jukit#cells#delete()<cr>", "Delete Cell" },
--     }
--   end
-- })

-- table.insert(lvim.plugins, { "hashivim/vim-terraform",
--   ft = "terraform"
-- })
