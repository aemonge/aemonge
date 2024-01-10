local M = {}

require("settings.lsp.helpers")

local ufo = require("settings.lsp.nvim-ufo")
table.insert(M, ufo)

-- https://github.com/creativenull/diagnosticls-configs-nvim/blob/main/supported-linters-and-formatters.md
table.insert(M, {
    "creativenull/diagnosticls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    -- config = function()
    -- local dlsconfig = require 'diagnosticls-configs'
    -- end
})

table.insert(M, {
    "neoclide/coc.nvim",
    branch = 'release',
    dependencies = { "ms-jpq/coq.artifacts", "ms-jpq/coq.thirdparty" },
    build = function()
        local extensions = require("settings.lsp.coc-extensions")
        for _, deps in pairs(extensions.list) do
            for _, dependency in ipairs(deps) do
                vim.cmd(":CocInstall " .. dependency)
            end
        end
    end,
    keys = {
        -- Normal mode keymaps
        -- { 'gd', '<CMD>lua _G.goto_priority()<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Definition, type, implementation, references" },
        -- { 'gn', '<Plug>(coc-diagnostic-next)', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Next Diagnostic" },
        -- { 'gp', '<Plug>(coc-diagnostic-prev)', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Previous Diagnostic" },

        -- Visual and operator-pending mode keymaps
        -- { 'if', '<Plug>(coc-funcobj-i)', { silent = true, expr = true, nowait = true }, mode = "x", desc = "Function object inside" },
        -- { 'af', '<Plug>(coc-funcobj-a)', { silent = true, expr = true, nowait = true }, mode = "x", desc = "Function object around" },
        -- { 'ic', '<Plug>(coc-classobj-i)', { silent = true, expr = true, nowait = true }, mode = "x", desc = "Class object inside" },
        -- { 'ac', '<Plug>(coc-classobj-a)', { silent = true, expr = true, nowait = true }, mode = "x", desc = "Class object around" },

        -- Insert mode keymaps
        -- { '<c-o>',   'coc#refresh()',                                                                            { silent = true, replace_keycodes = false, expr = true, noremap = true, nowait = true }, mode = "i", desc = "Trigger Completion" },
        -- { '<c-j>',   '<Plug>(coc-snippets-expand-jump)',                                                         { silent = true, replace_keycodes = false, expr = true, noremap = true, nowait = true }, mode = "i", desc = "Trigger Snippets" },
        -- { '<c-k>',   'coc#pum#visible() ? coc#pum#confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"',     { silent = true, replace_keycodes = false, expr = true, noremap = true, nowait = true }, mode = "i", desc = "Confirm Selection" },
        -- { '<c-n>',   'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', { silent = true, replace_keycodes = false, expr = true, noremap = true, nowait = true }, mode = "i", desc = "Next selection" },
        -- { '<c-p>',   'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-h>"',                                          { silent = true, replace_keycodes = false, expr = true, noremap = true, nowait = true }, mode = "i", desc = "Prev selection" },
        -- { '<TAB>',   'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', { silent = true, replace_keycodes = false, expr = true, noremap = true, nowait = true }, mode = "i", desc = "Next selection" },
        -- { '<S-TAB>', 'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-h>"',                                          { silent = true, replace_keycodes = false, expr = true, noremap = true, nowait = true }, mode = "i", desc = "Prev selection" },
        -- { '<c-s>',   '<C-X><C-S>',                                                                               { silent = true, replace_keycodes = false, noremap = true, nowait = true },              mode = "i", desc = "Trigger spelling completion." },
        --
        -- Leader keymaps
        -- { '<leader>K', '<CMD>lua _G.show_docs()<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Show Documentation" },
        -- { '<leader>d', '<CMD>lua _G.show_diagnostic_line()<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "  Diagnostic hover" },
        -- { '<leader>f', '<CMD>Format<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "  Format " },
        -- { '<leader>g', ':Gitsigns blame_line<cr>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "  Git blame" },

        -- Leader Grouped keymaps
        -- { '<leader>la', '<CMD>lua _G.code_action_priority()<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Code actions" },
        -- { '<leader>l.', ':<C-u>CocList commands<cr>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Show CoC Commands" },
        -- { '<leader>lr', ':CocRestart<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Restart CoC" },
        -- { '<leader>lC', ':CocConfig<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Configuration" },
        -- { '<leader>lc', ':CocLocalConfig<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Local Configuration" },
        -- { '<leader>lL', ":lua require('lazy').update({show = false})<CR>", { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Lazy and CoC Update" },
        -- { '<leader>ll', ':Lazy<CR>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Lazy" },
        -- { '<leader>lM', ':CocList marketplace<cr>', { silent = true, noremap = true, nowait = true }, mode = "n", desc = "Coc Marketplace" },
        -- { '<leader>la', '<CMD>lua _G.code_action_priority()<CR>', { silent = true, noremap = true, nowait = true }, mode = "v", desc = "LSP and COC actions" },
    },
    config = function()
        require("settings.lsp.mappings.coc-autocomplete")
        require("settings.lsp.mappings.coc-diagnostics")
        require("settings.lsp.mappings.coc-goto")
        require("settings.lsp.mappings.coc-lsp")
        require("settings.lsp.mappings.coc-func-object")
    end
})

return M
