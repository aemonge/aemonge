local M = {}

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

function _G.is_hover_open()
  local is_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'nofile' then
      is_open = true
      break
    end
  end
  return is_open
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
        vim.cmd('sleep 200m') -- Give some time for the hover window to open
        if _G.is_hover_open() then
            vim.api.nvim_command('wincmd w')
        end
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

table.insert(M, {
    "neoclide/coc.nvim",
    branch = 'release',
    dependencies = { "ms-jpq/coq.artifacts", "ms-jpq/coq.thirdparty" },
    build = function()
        vim.cmd [[:CocInstall @yaegassy/coc-black-formatter]]
        vim.cmd [[:CocInstall @yaegassy/coc-mypy]]
        vim.cmd [[:CocInstall @yaegassy/coc-nginx]]
        vim.cmd [[:CocInstall @yaegassy/coc-pylsp]]
        vim.cmd [[:CocInstall coc-cl]]
        vim.cmd [[:CocInstall coc-css]]
        vim.cmd [[:CocInstall coc-diagnostic]]
        vim.cmd [[:CocInstall coc-docker]]
        vim.cmd [[:CocInstall coc-eslint]]
        vim.cmd [[:CocInstall coc-git[]]
        vim.cmd [[:CocInstall coc-html]]
        vim.cmd [[:CocInstall coc-htmlhint]]
        vim.cmd [[:CocInstall coc-jedi]]
        vim.cmd [[:CocInstall coc-json]]
        vim.cmd [[:CocInstall coc-markdown-preview-enhanced]]
        vim.cmd [[:CocInstall coc-markdownlint]]
        vim.cmd [[:CocInstall coc-prettier]]
        vim.cmd [[:CocInstall coc-pydocstring]]
        vim.cmd [[:CocInstall coc-sh]]
        vim.cmd [[:CocInstall coc-snippets]]
        vim.cmd [[:CocInstall coc-spell-checker]]
        vim.cmd [[:CocInstall coc-sql]]
        vim.cmd [[:CocInstall coc-stylelint]]
        vim.cmd [[:CocInstall coc-stylua]]
        vim.cmd [[:CocInstall coc-tabnine]]
        vim.cmd [[:CocInstall coc-vimlsp]]
        vim.cmd [[:CocInstall coc-yaml]]
        vim.cmd [[:CocInstall tsserver]]
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
            K = { "<CMD>lua _G.show_docs()<CR>", "Show Diagnostic"},
        }, {
          mode = "n",
          prefix = nil,
          buffer = nil,
          silent = true,
          noremap = true,
          nowait = true,
        })


        -- GoTos
        keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
        keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
        keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
        keyset("n", "gr", "<Plug>(coc-references)", { silent = true })
        wk.register( {
            d = { "<Plug>(coc-definition)", "Definition"},
            D = { "<Plug>(coc-type-definition)", "Type Definition"},
            i = { "<Plug>(coc-implementation)", "Implementation"},
            r = { "<Plug>(coc-references)", "References"},

            n = { "<Plug>(coc-diagnostic-next)", "Next Diagnostic"},
            p = { "<Plug>(coc-diagnostic-prev)", "Previous Diagnostic"},
          },
          {
              prefix = "g",
              buffer = nil,
              silent = true,
              noremap = true,
              nowait = true,
          }
        )

        wk.register( {
          A = { "<Plug>(coc-codeaction-source)", "More actions source" },
          F = { "<Plug>(coc-fix-current)", "Fix current" },
          a = { "<Plug>(coc-codeaction-selected)", "More actions" },
          c = { ":<C-u>CocList commands<cr>", "Show CoC Commands" },
          F = { "<Plug>(coc-format-selected)", "Format selected" },
          f = { "<Plug>(coc-format)", "Format file" },
          l = { "<Plug>(coc-codelens-action)", "Code Lens" },
          m = { "<Plug>(coc-rename)", "Symbol renaming" },
          r = { "<Plug>(coc-fix-refactor-selected)", "Refactor selected" },
          ['.'] = { ":CocConfig<CR>", "Configuration" },
        }, {
          mode = {"n", "x" },
          prefix = "<leader>l",
          name = "LSP and COC actions",
          buffer = nil,
          silent = true,
          noremap = true,
          nowait = true,
        })

        wk.register( {
          t = { ":<C-u>CocList diagnostics<cr>", "Show Diagnostics" },
          s = { ":<C-u>CocList -I symbols<cr>", "Show CoC Symbols" },
        }, {
          mode = {"n", "x" },
          prefix = "<leader>t",
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

        -- Map function and class text objects.  Requires 'textDocument.documentSymbol' support from the language server
        wk.register({
            ["if"] = { "<Plug>(coc-funcobj-i)"  },
            ["if"] = { "<Plug>(coc-funcobj-i)"  },
            ["af"] = { "<Plug>(coc-funcobj-a)"  },
            ["af"] = { "<Plug>(coc-funcobj-a)"  },
            ["ic"] = { "<Plug>(coc-classobj-i)" },
            ["ic"] = { "<Plug>(coc-classobj-i)" },
            ["ac"] = { "<Plug>(coc-classobj-a)" },
            ["ac"] = { "<Plug>(coc-classobj-a)" }
        }, { silent = true, nowait = true, expr = true, mode = {"x", "o"} })

        -- Remap <C-s> and <C-d> to scroll float windows/popups
        wk.register({
            ["<c-s>"] = { 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-s>"'  },
            ["<c-d>"] = { 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-d>"' },
        }, { silent = true, nowait = true, expr = true, mode = {"n", "v"} })
        wk.register({
            ["<c-s>"] = { 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"'  },
            ["<c-d>"] = { 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"' },
        }, { silent = true, nowait = true, expr = true, mode = "i" })

        -- Add `:Format`, `:Fold`, `:OR` command to format current buffer
        vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
        vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })
        vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

        -- Add (Neo)Vim's native statusline support
        vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

        -- Sourcery
        -- vim.cmd[[
        --     nnoremap <silent> <leader>cl :CocDiagnostics<cr>
        --     nnoremap <silent> <leader>ch :call CocAction('doHover')<cr>
        --     nnoremap <silent> <leader>cf <plug>(coc-codeaction-cursor)
        --     nnoremap <silent> <leader>ca <plug>(coc-fix-current)
        --
        --     nmap <silent> [c <plug>(coc-diagnostic-prev)
        --     nmap <silent> ]c <plug>(coc-diagnostic-next)
        -- ]]
    end

})

return M
