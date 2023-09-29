local function chat_ui(param, newTab)
    if not newTab then
        vim.cmd("tabnew")
    end
    vim.cmd("edit /tmp/query.md")

    local win_id_query = vim.api.nvim_get_current_win()
    local buf_query = vim.api.nvim_get_current_buf()

    -- Splitting at right a new ':terminal' & setting query.md buffer to 8 9 width
    if vim.fn.winwidth(0) > 150 then
        if param == 1 then
            vim.cmd("vsplit term://chatd 1")
        else
            vim.cmd("vsplit term://chatd")
        end
        -- Set the window associated with /tmp/query.md to the width of 88
        vim.api.nvim_win_set_width(win_id_query, 94)
    else
        if param == 1 then
            vim.cmd("split term://chatd 1")
        else
            vim.cmd("split term://chatd")
        end
    end

    -- Perform buffer manipulations
    local buf_term = vim.api.nvim_get_current_buf() -- get the buffer number of the terminal

    -- Set the yanking mode to avoid line brakes
    vim.cmd([[
    function! JoinYank()
        let @0 = substitute(@0, '\n', ' ', 'g') " replace line breaks with spaces
        let @\" = @0 " update the unnamed register with the modified content
    endfunction
    ]])

    -- Closing one buffer kills the other
    vim.api.nvim_exec(
        [[ autocmd BufDelete <buffer> lua vim.api.nvim_buf_delete(buf_query, {force = true}) ]],
        false)

    -- set the terminal buffer mappings
    vim.api.nvim_buf_set_keymap(buf_term, "n", "y", ":call JoinYank()<CR>", {
        noremap = true,
        silent = true
    })

    -- set the terminal buffer to markdown file type
    vim.api.nvim_buf_set_option(buf_term, "ft", "markdown")
    vim.o.showtabline = 0
    vim.o.autoread = true

    -- Set a buffer variable
    vim.api.nvim_buf_set_var(buf_term, "is_chat_term", true)

    -- go back to /tmp/query.md buffer
    vim.cmd("wincmd w")

    -- Closing one buffer kills the other
    vim.api.nvim_exec(
        [[ autocmd BufDelete <buffer> lua vim.api.nvim_buf_delete(buf_term, {force = true}) ]],
        false)
end

return chat_ui
