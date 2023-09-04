function ClearTerm()
    vim.opt_local.scrollback = 1

    vim.api.nvim_command("startinsert")
    vim.api.nvim_feedkeys("clear", "t", false)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<cr>", true, false, true),
        "t",
        true
    )

    vim.opt_local.scrollback = 10000
end

function Tapi_Tabe(files)
    for file in string.gmatch(files, "[^%s]+") do
        vim.cmd(string.format("tabe %s", file))
    end
end

function Tapi_Cd(cwd)
    vim.cmd(string.format("cd %s", cwd))
end

function NewTermTab()
    vim.api.nvim_command(":tabnew")
    vim.api.nvim_command("terminal")
    vim.api.nvim_command("startinsert")
end
