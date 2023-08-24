-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Update all package managers
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyUpdate",
    command = "MasonUpdateAll",
    desc = "Run MasonUpdate after LazyUpdate"
})
vim.api.nvim_create_autocmd('User', {
    pattern = 'MasonUpdateAllComplete',
    command = "CocUpdate",
    desc = "Run CocUpdate after MasonUpdate"
})

-- Create new Fold, Format and OR commands
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
