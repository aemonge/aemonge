local M = {}

function M.setup()
    local opts = { noremap = true, silent = true }

    -- vim.api.nvim_buf_set_keymap(0, 'i', '<c-h>', '<c-w><Left>', opts)
    -- vim.api.nvim_buf_set_keymap(0, 'i', '<c-j>', '<c-w><Down>', opts)
    -- vim.api.nvim_buf_set_keymap(0, 'i', '<c-k>', '<c-w><Up>', opts)
    -- vim.api.nvim_buf_set_keymap(0, 'i', '<c-l>', '<c-w><Right>', opts)

    vim.api.nvim_buf_set_keymap(0, 'i', '<Tab>', 'pumvisible() ? "<C-n>" : "<C-x><C-o>"', { expr = true })
end

return M
