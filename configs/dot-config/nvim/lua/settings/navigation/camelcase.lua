---------------------------------------------------------------------------
--  Camel Case Motion
---------------------------------------------------------------------------
local M = {}

table.insert(M, {
    "bkad/CamelCaseMotion",
    dependencies = "folke/which-key.nvim",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
        "data",
        "versionControl",
    }),
    keys = {
        { 'w',  '<Plug>CamelCaseMotion_w',  { silent = true }, mode = { 'n', 'x', 'o' } },
        { 'b',  '<Plug>CamelCaseMotion_b',  { silent = true }, mode = { 'n', 'x', 'o' } },
        { 'e',  '<Plug>CamelCaseMotion_e',  { silent = true }, mode = { 'n', 'x', 'o' } },
        { 'iw', '<Plug>CamelCaseMotion_iw', { silent = true }, mode = { 'o', 'x' } },
        { 'ib', '<Plug>CamelCaseMotion_ib', { silent = true }, mode = { 'o', 'x' } },
        { 'ie', '<Plug>CamelCaseMotion_ie', { silent = true }, mode = { 'o', 'x' } },
    }
})

return M
