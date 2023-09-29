local M = {}

M.M = {
    v = {
        name = "+dap (debugger)",
        v = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle DAP UI" },
        [","] = { "<cmd>lua require'dap'.run_last()<CR>", "Run last" },
        S = { "<cmd>lua require'dap'.terminate()<CR>", "Terminate" },
        s = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },

        n = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
        i = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
        o = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },

        d = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
            "Toggle Breakpoint" },
    }
}

M.O = {

    mode = { "n" },
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

return M
