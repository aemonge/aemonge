local M = {}
local cache = {}
local tempfileExist = {}

M.getOrCreateTempFilePath = function(program)
    if tempfileExist[program] then
        return tempfileExist[program]
    else
        local tempFilePath = "/tmp/" .. program .. ".sh"
        tempfileExist[program] = tempFilePath
        return tempFilePath
    end
end

M.openBufferAndReturnArgs = function(program)
    local tempFilePath = M.getOrCreateTempFilePath(program)
    if not cache[program] then
        vim.cmd(string.format("split %s", tempFilePath)) -- create new buffer with tempfile
        vim.bo.filetype = 'bash'
        vim.cmd [[setlocal nonu]]
        vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<Esc>", {})
        vim.api.nvim_win_set_height(0, 8) --limit height to 8 lines
        vim.api.nvim_buf_attach(0, false, {
            on_detach = function(_, buf)
                cache[program] = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                return true
            end
        })
    end
    return cache[program] or {}
end

return M
