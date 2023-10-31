local M = {}

M.M = {
    l = {
        -- s = { "<cmd>:VenvSelect<cr>", "select py-virtual environment" },
        s = { function() require('swenv.api').pick_venv() end, "select py-virtual environment" },
        -- S = { "<cmd>:VenvSelectCached<cr>", "select py-virtual environment" }
    }

}

M.O = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
