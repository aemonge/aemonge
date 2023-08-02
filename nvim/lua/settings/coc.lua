local M = {}

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

function _G.goto_priority()
    if vim.fn.CocHasProvider('definition') then
        vim.fn.CocAction('jumpDefinition')
    elseif vim.fn.CocHasProvider('typeDefinition') then
        vim.fn.CocAction('jumpTypeDefinition')
    elseif vim.fn.CocHasProvider('implementation') then
        vim.fn.CocAction('jumpImplementation')
    elseif vim.fn.CocHasProvider('references') then
        vim.fn.CocAction('findReferences')
    end
end

function _G.goto_file()
    if vim.fn.CocHasProvider('definition') then
        vim.fn.CocAction('jumpDefinition')
    else
        vim.cmd("normal gf")
    end
end

function _G.code_action_priority()
    if vim.fn.CocHasProvider('codeAction') then
        vim.fn.CocAction('codeAction')
    elseif vim.fn.CocHasProvider('codeLens') then
        vim.fn.CocAction('codeLensAction')
    end
end

function _G.show_hover_line()
    local win_id = vim.api.nvim_eval('g:coc_last_float_win')

    -- Check if the window is valid and listed (i.e., visible)
    if win_id and vim.api.nvim_win_is_valid(win_id) then
        if vim.fn.CocHasProvider('hover') then
          vim.fn.CocAction('doHover')
        else
          vim.api.nvim_set_current_win(win_id)
        end
    else
        -- Check if there's diagnostic information for the current line
        local has_diagnostics = vim.fn.CocAction('diagnosticInfo')

        if not has_diagnostics or has_diagnostics == 0 then
            -- If there are no diagnostics, try to show hover info
            if vim.fn.CocHasProvider('hover') then
                vim.fn.CocAction('showLineHover')
            end
        end
    end
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')

    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        if vim.fn.CocHasProvider('hover') then
            local win_id = vim.api.nvim_eval('g:coc_last_float_win')

            -- Check if the window is valid and listed (i.e., visible)
            if win_id and vim.api.nvim_win_is_valid(win_id) then
                vim.api.nvim_set_current_win(win_id)
            else
                vim.fn.CocAction('doHover')
            end
        else
            vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
    else
        vim.api.nvim_command('K')
    end
end

table.insert(M, {
    "neoclide/coc.nvim",
    branch = 'release',
    dependencies = { "ms-jpq/coq.artifacts", "ms-jpq/coq.thirdparty" },
    build = function()
        -- PYTHON
        vim.cmd[[:CocInstall coc-pyright]]
        -- vim.cmd[[:CocInstall coc-black-formatter]]
        -- vim.cmd[[:CocInstall coc-mypy]]

        -- BACKEND
        vim.cmd[[:CocInstall coc-lua]]
        -- vim.cmd[[:CocInstall coc-stylua]]
        vim.cmd[[:CocInstall coc-sumneko-lua]]
        vim.cmd[[:CocInstall coc-clangd]]

        -- FRONTEND
        vim.cmd[[:CocInstall coc-css]]
        vim.cmd[[:CocInstall coc-html]]
        vim.cmd[[:CocInstall coc-prettier]]
        vim.cmd[[:CocInstall coc-stylelint]]
        vim.cmd[[:CocInstall coc-tsserver]]

        -- DATABASES
        vim.cmd[[:CocInstall coc-sql]]

        -- DEVOPS
        vim.cmd[[:CocInstall coc-sh]]
        vim.cmd[[:CocInstall coc-docker]]
        vim.cmd[[:CocInstall @yaegassy/coc-nginx]]

        -- TEXT-MARKDOWNS
        vim.cmd[[:CocInstall coc-yaml]]
        vim.cmd[[:CocInstall coc-markdownlint]]
        vim.cmd[[:CocInstall coc-eslint]]
        vim.cmd[[:CocInstall coc-json]]
        vim.cmd[[:CocInstall coc-toml]]
        vim.cmd[[:CocInstall coc-markdown-preview-enhanced]]
        vim.cmd[[:CocInstall coc-esbonio]]

        -- TOOLS-EXTENSIONS
        vim.cmd[[:CocInstall coc-snippets]]
        vim.cmd[[:CocInstall coc-tabnine]]
        vim.cmd[[:CocInstall coc-pairs]]
        vim.cmd[[:CocInstall coc-spell-checker]]
        vim.cmd[[:CocInstall coc-diagnostic]]
        vim.cmd[[:CocInstall coc-vimlsp]]
    end,
    config = function()
        local wk = require("which-key")
        local keyset = vim.keymap.set

        -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
        vim.api.nvim_create_augroup("CocGroup", {})
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "CocGroup",
            command = "silent call CocActionAsync('highlight')",
            desc = "Highlight symbol under cursor on CursorHold"
        })

        -- Autocomplete
        wk.register({
            ["<c-s>"] = { 'i<C-X><C-S>', "Trigger spelling completion." },
            -- ["<c-f>"] = { 'i<C-X><C-F>', "Trigger file completion." },
        }, { mode = "i", noremap = true, silent = true, nowait = true, })
        wk.register({
            ["<c-o>"] = { "coc#refresh()", "Trigger Completion" },
            ["<c-j>"] = { "<Plug>(coc-snippets-expand-jump)", "Trigger Snippets" },
            ["<c-k>"] = {
              [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
              "Confirm Selection"
            },
            ["<c-n>"] = {
                'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
                "Next selection"
            },
            ["<c-p>"] = {
                [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],
                "Prev selection"
            },
            ["<TAB>"] = {
                'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
                "Next selection"
            },
            ["<S-TAB>"] = {
                [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],
                "Prev selection"
            },
        }, {
          mode = "i",
          replace_keycodes = false,
          expr = true,
          prefix = nil,
          buffer = nil,
          silent = true,
          noremap = true,
          nowait = true,
        })

        -- Diagnostics
        wk.register({
            K = { "<CMD>lua _G.show_docs()<CR>", "Show Documentation" }
        }, {
          mode = "n",
          prefix = nil,
          buffer = nil,
          silent = true,
          noremap = true,
          nowait = true,
        })


        -- GoTos
        wk.register( {
            d = { "<CMD>lua _G.goto_priority()<CR>", "Definition, type, implementation, references"},
            f = { "<CMD>lua _G.goto_file()<CR>", "File"},

            n = { "<Plug>(coc-diagnostic-next)", "Next Diagnostic"},
            p = { "<Plug>(coc-diagnostic-prev)", "Previous Diagnostic"},
          },
          {
              mode = "n",
              name = "Go to ...",
              prefix = "g",
              buffer = nil,
              silent = true,
              noremap = true,
              nowait = true,
          }
        )

        wk.register({
            d = { "<CMD>lua _G.show_hover_line()<CR>", "Diagnostic hover" },
        }, {
            mode = "n",
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })

        wk.register( {
            a = { "<CMD>lua _G.code_action_priority()<CR>", "Code actions" },
            f = { "<Plug>(coc-format)", "Format file" },

            ['.'] = { ":<C-u>CocList commands<cr>", "Show CoC Commands" },
            r = { ":CocRestart<CR>", "Restart CoC" },
            C = { ":CocConfig<CR>", "Configuration" },
            c = { ":CocLocalConfig<CR>", "Local Configuration" },
            l = { ":lua require('lazy').update({show = false})<CR>", "Lazy and CoC Update"}
        }, {
            mode = "n",
            prefix = "<leader>l",
            name = "LSP and COC actions",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })

        wk.register( {
            a = { "<CMD>lua _G.code_action_priority()<CR>", "Code actions" },
            f = { "<Plug>(coc-format-selected)", "Format" },
        }, {
            mode = "v",
            prefix = "<leader>l",
            name = "LSP and COC actions",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })

        -- Update signature help on jump placeholder
        vim.api.nvim_create_autocmd("User", {
            group = "CocGroup",
            pattern = "CocJumpPlaceholder",
            command = "call CocActionAsync('showSignatureHelp')",
            desc = "Update signature help on jump placeholder"
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyUpdate",
            command = "CocUpdate",
            desc = "Run CocUpdate after LazyUpdate"
        })

        -- Map function and class text objects.  Requires 'textDocument.documentSymbol' support from the language server
        wk.register({
            ["if"] = { "<Plug>(coc-funcobj-i)"  },
            ["af"] = { "<Plug>(coc-funcobj-a)"  },
            ["ic"] = { "<Plug>(coc-classobj-i)" },
            ["ac"] = { "<Plug>(coc-classobj-a)" }
        }, { silent = true, nowait = true, expr = true, mode = {"x", "o"} })

        vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
        vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })
        vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

        -- Add (Neo)Vim's native statusline support
        vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")
    end

})

return M
