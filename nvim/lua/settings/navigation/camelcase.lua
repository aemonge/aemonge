---------------------------------------------------------------------------
--  Camel Case Motion
---------------------------------------------------------------------------
local M = {}

table.insert(M, { "bkad/CamelCaseMotion",
  dependencies =  "folke/which-key.nvim" ,
  config = function ()
    local mapping_opts ={ buffer = nil, silent = true, noremap = true, nowait = true }
    vim.keymap.set('', 'w', '<Plug>CamelCaseMotion_w', mapping_opts)
    vim.keymap.set('', 'b', '<Plug>CamelCaseMotion_b', mapping_opts)
    vim.keymap.set('', 'e', '<Plug>CamelCaseMotion_e', mapping_opts)
    vim.keymap.set('', 'ge', '<Plug>CamelCaseMotion_ge', mapping_opts)
    vim.keymap.del('s', 'w')
    vim.keymap.del('s', 'b')
    vim.keymap.del('s', 'e')
    vim.keymap.del('s', 'ge')
    vim.keymap.set('o', 'iw', '<Plug>CamelCaseMotion_iw', mapping_opts)
    vim.keymap.set('x', 'iw', '<Plug>CamelCaseMotion_iw', mapping_opts)
    vim.keymap.set('o', 'ib', '<Plug>CamelCaseMotion_ib', mapping_opts)
    vim.keymap.set('x', 'ib', '<Plug>CamelCaseMotion_ib', mapping_opts)
    vim.keymap.set('o', 'ie', '<Plug>CamelCaseMotion_ie', mapping_opts)
    vim.keymap.set('x', 'ie', '<Plug>CamelCaseMotion_ie', mapping_opts)

    local mappings = require("settings.navigation.mappings")
    local wk = require("which-key")
    wk.register(mappings, mapping_opts)
  end
})

return M
