local M = {}

table.insert(M, { "jmbuhr/otter.nvim",
  config = function ()
    local otter = require'otter'

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = { "*.qmd" },
      callback = function()
        -- otter.activate({ 'r', 'python', 'lua' }, true)
        otter.activate({ 'python', 'lua' }, true)
        vim.api.nvim_buf_set_keymap(0, 'n', 'gd', ":lua require'otter'.ask_definition()<cr>", { silent = true })
        vim.api.nvim_buf_set_keymap(0, 'n', 'K', ":lua require'otter'.ask_hover()<cr>", { silent = true })
      end,
    })
  end
})

return M
