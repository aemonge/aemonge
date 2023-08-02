local M = {}

_G.dynamicTerm = nil

table.insert(M, {
    "akinsho/toggleterm.nvim", -- version = "*",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
        "data",
        "versionControl",
    }),
    config = function()
        local ToggleTerm = require("toggleterm")

        local function get_term_command()
            local filetype = vim.bo.filetype
            if filetype == "sh" then
                if vim.fn.executable("zsh") == 1 then
                    return "zsh"
                elseif vim.fn.executable("bash") == 1 then
                    return "bash"
                end
            elseif filetype == "zsh" then
                return "zsh"
            elseif filetype == "python" then
                if vim.fn.executable("ipython") == 1 then
                    return "ipython"
                end
            elseif filetype == "javascript" then
                return "node -i"
            end
            return nil
        end


        ToggleTerm.setup({
            hide_numbers = true, -- hide the number column in toggleterm buffers
            autochdir = true,    -- based on the current working directory of neovim
            shade_terminals = false,
            start_in_insert = true,
            normal_mappings = false,
            insert_mappings = false,  -- whether or not the open mapping applies in insert mode
            terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
            persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
            direction = "float",      -- 'vertical' | 'horizontal' | 'tab' | 'float',
            on_close = function(_)
                require("tint").untint(vim.api.nvim_get_current_win())
            end,
            on_exit = function(_)
                require("tint").untint(vim.api.nvim_get_current_win())
            end,
            auto_scroll = true, -- automatically scroll to the bottom on terminal output
            highlights = {
                Terminal = {
                    guibg = "NONE",
                    bg = "NONE",
                },
            },
            float_opts = {
                border = "rounded",
                width = function()
                    return math.floor(vim.o.columns * 0.75)
                end,
                height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
            },
        })

        local dynamicTerm = require("toggleterm.terminal").Terminal:new({
            cmd = get_term_command(),
            hidden = true
        })

        function Toggle_dynamic_term()
            dynamicTerm:toggle()
        end

        vim.api.nvim_set_keymap(
            "n", "<leader>x", "<cmd>lua Toggle_dynamic_term()<CR>", { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
            "n", "<leader>X", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true }
        )
    end,
})

return M
