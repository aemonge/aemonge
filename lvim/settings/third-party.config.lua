--------------------------------------------------------------------------------------------------------------------------
--                                                 Hipster and Third-party                                               |
--------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------
-- Glow, and Ghost text
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "npxbr/glow.nvim",
  config = function ()
    require('glow').setup({
      pager=true,
      width=150 -- TODO: Change to a bigger number such as 160, once you set the text with to 150 on md/text/...
    })
  end
})

---------------------------------------------------------------------------
-- Ghost text
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "subnut/nvim-ghost.nvim",
  build = ":call nvim_ghost#installer#install()"
})

vim.cmd [[
  augroup nvim_ghost_user_autocommands
    au User www.reddit.com,www.stackoverflow.com set filetype=markdown
    au User www.reddit.com,www.github.com set filetype=markdown
    au User *github.com set filetype=markdown
    au User localhost set filetype=markdown
    au User *.com,*.org,*.net,*.gob set filetype=markdown
  augroup END
]]
