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
                    "Ofrom pprint import pprint; import sys; import ipdb; ipdb.set_trace()<esc>",
                    "n",
                    false
                )
            end
        end

        local open = function()
            return require("neotest").output.open({ enter = true, auto_close = true })
        end

        local run = function()
            return require("neotest").run.run({ strategy = "integrated" })
        end

        local current = function()
            return require("neotest").run.run(vim.fn.expand("%"), { strategy = "integrated" })
        end

        require("which-key").register({
            ["dn"] = { run, "Nearest Test" },
            ["dc"] = { current, "Test Current file" },
            ["ds"] = { require("neotest").run.stop, "Stop Test" },
            ["do"] = { open, "Output Open" },
            ["da"] = { require("neotest").run.attach, "Attach Test" },
            ["db"] = { info, "Start Breakpoint" },
        }, {
            mode = "n",
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end,
})

return M
