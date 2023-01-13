--------------------------------------------------------------------------------------------------------------------------
--                                                      Code Debug                                                       |
--------------------------------------------------------------------------------------------------------------------------
local textwidth = 120

---------------------------------------------------------------------------
-- DAP, console.logs, enable line interpreters and quick code run
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "rmagatti/goto-preview",
  config = function()
  require('goto-preview').setup {
        width = textwidth; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = false; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = 0.88; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
    }
  end
})

---------------------------------------------------------------------------
-- DAP, console.logs, enable line interpreters and quick code run
---------------------------------------------------------------------------
-- table.insert(lvim.plugins, { "metakirby5/codi.vim",
--   cmd = "Codi"
-- })
