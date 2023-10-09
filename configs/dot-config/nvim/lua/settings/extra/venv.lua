local M = {}

local function coc_hook()
  vim.api.nvim_command('CocRestart')
end

table.insert(M, {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  config = function()
    local venv_selector = require("venv-selector")
    venv_selector.setup({
      dap_enabled = true,
      anaconda_envs_path = "~/.conda/envs",
      changed_venv_hooks = { coc_hook, venv_selector.hooks.pyright }
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Auto select virtualenv Nvim open",
      pattern = "*",
      callback = function()
        local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
        if venv ~= "" then
          require("venv-selector").retrieve_from_cache()
        end
      end,
      once = true,
    })
  end
})

return M
