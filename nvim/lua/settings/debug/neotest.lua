local M = {}

local function get_virtual_path(executable)
    local handle = io.popen("which " .. executable .. " 2> /dev/null ")
    local result = handle:read("*a")
    handle:close()
    local path = result:match("^%s*(.-)%s*$")
    if path and #path > 0 then
        return path
    else
        return nil
    end
end

table.insert(M, {
    "nvim-neotest/neotest",
    ft = require("file-types")({
        "languages",
    }),
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest-python")({
            python = get_virtual_path("python"),
        })
        require("neotest").setup({
            adapters = {
                require("neotest-python"),
            },
        })

        local info = function()
            local filetype = vim.bo.filetype
            if filetype == "python" then
                vim.api.nvim_feedkeys(
                    "Ofrom pprint import pprint; import sys; import ipdb; ipdb.set_trace()",
                    "n",
                    false
                )
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes(
                        "<ESC>", true, true, true
                    ), "n", false
                )
            end
        end

        local open = function()
            return require("neotest").output.open({
                enter = true,
                auto_close = true,
            })
        end

        local run = function()
            return require("neotest").run.run({ strategy = "integrated" })
        end

        local current = function()
            return require("neotest").run.run(
                vim.fn.expand("%"),
                { strategy = "integrated" }
            )
        end

        require("which-key").register({
            n = { run, "Nearest Test" },
            c = { current, "Test Current file" },
            s = { require("neotest").run.stop, "Stop Test" },
            o = { open, "Output Open" },
            a = { require("neotest").run.attach, "Attach Test" },
            b = { info, "Start Breakpoint" },
        }, {
            mode = "n",
            name = "Debugger",
            prefix = "<leader>v",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end,
})

return M
