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

function _G.code_action_priority()
    if vim.fn.CocHasProvider('codeAction') then
        vim.fn.CocAction('codeAction')
    elseif vim.fn.CocHasProvider('codeLens') then
        vim.fn.CocAction('codeLensAction')
    end
end

function _G.show_diagnostic_line()
    local win_id = vim.fn.exists("g:coc_last_float_win") and vim.g.coc_last_float_win or nil

    if win_id and vim.api.nvim_win_is_valid(win_id) then
        vim.api.nvim_set_current_win(win_id)
    else
        local has_diagnostics = vim.fn.CocAction('diagnosticInfo')
        if not has_diagnostics or has_diagnostics == 0 then
            if vim.fn.CocHasProvider('hover') then
                vim.fn.CocAction('showLineHover')
            end
        end
    end
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    local win_id = vim.fn.exists("g:coc_last_float_win") and vim.g.coc_last_float_win or nil

    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.cmd('h ' .. cw)
    elseif win_id and vim.api.nvim_win_is_valid(win_id) then
        vim.api.nvim_set_current_win(win_id)
    elseif vim.fn['coc#rpc#ready']() then
        vim.api.nvim_command("redir => g:myOutput")
        vim.api.nvim_command([[
          try
            silent call CocAction('definitionHover')
          catch
            execute "!" . &keywordprg . " " . ']] .. cw .. [['
          endtry
        ]])
        vim.api.nvim_command("redir END")
        local output = vim.g.myOutput or ""
        if string.match(output, "hover not found") then
            vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
    else
        vim.api.nvim_command('normal! K')
    end
end
