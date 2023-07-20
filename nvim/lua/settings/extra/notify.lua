local M = {}

table.insert(M, {
    "rcarriga/nvim-notify",
    priority = 99999,
    config = function()
        require("notify").setup({
            background_colour = "#000000",
            max_width = 70,
            stages = "slide",
            timeout = 2000,
        })
        vim.notify = require("notify")

        -- COC Support notify
        local coc_status_record = {}

        function coc_status_notify(msg, level)
            local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true,
                on_close = reset_coc_status_record }
            -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
            if coc_status_record ~= {} then
                notify_opts["replace"] = coc_status_record.id
            end
            coc_status_record = vim.notify(msg, level, notify_opts)
        end

        function reset_coc_status_record(window)
            coc_status_record = {}
        end

        vim.cmd [[
            function! s:StatusNotify() abort
              let l:status = get(g:, 'coc_status', '')
              let l:level = 'info'
              if empty(l:status) | return '' | endif
              call v:lua.coc_status_notify(l:status, l:level)
            endfunction

            " notifications
            autocmd User CocStatusChange call s:StatusNotify()
        ]]
    end,
})

return M
