local M = {}

table.insert(M, { "bootleq/vim-cycle",
  config = function ()
    vim.g.cycle_no_mappings = 1
    vim.cmd [[ nmap <silent> <C-a> <Plug>CycleNext ]]
    vim.cmd [[ vmap <silent> <C-x> <Plug>CyclePrev ]]
    vim.cmd [[ noremap <silent> <Plug>CycleFallbackNext <C-A> ]]
    vim.cmd [[ noremap <silent> <Plug>CycleFallbackPrev <C-X> ]]

    vim.cmd [[ silent! call cycle#add_group([ 'set', 'get' ]) ]]
    vim.cmd [[ silent! call cycle#add_group(['form', 'to']) ]]
    vim.cmd [[ silent! call cycle#add_group(['push', 'pop']) ]]
    vim.cmd [[ silent! call cycle#add_group(['more', 'less']) ]]
    vim.cmd [[ silent! call cycle#add_group(['mas', 'menos']) ]]
    vim.cmd [[ silent! call cycle#add_group(['prev', 'next']) ]]
    vim.cmd [[ silent! call cycle#add_group(['start', 'end']) ]]
    vim.cmd [[ silent! call cycle#add_group(['light', 'dark']) ]]
    vim.cmd [[ silent! call cycle#add_group(['open', 'close']) ]]
    vim.cmd [[ silent! call cycle#add_group(['read', 'write']) ]]
    vim.cmd [[ silent! call cycle#add_group(['truthy', 'falsy']) ]]
    vim.cmd [[ silent! call cycle#add_group(['weight', 'height']) ]]
    vim.cmd [[ silent! call cycle#add_group(['filter', 'reject']) ]]
    vim.cmd [[ silent! call cycle#add_group(['disable', 'enable']) ]]
    vim.cmd [[ silent! call cycle#add_group(['const', 'let', 'var']) ]]
    vim.cmd [[ silent! call cycle#add_group(['disabled', 'enabled']) ]]
    vim.cmd [[ silent! call cycle#add_group(['internal', 'external']) ]]
    vim.cmd [[ silent! call cycle#add_group(['floor', 'round', 'ceil']) ]]
    vim.cmd [[ silent! call cycle#add_group(['subscribe', 'unsubscribe']) ]]
    vim.cmd [[ silent! call cycle#add_group(['header', 'body', 'footer']) ]]
    vim.cmd [[ silent! call cycle#add_group(['protected', 'private', 'public']) ]]
    vim.cmd [[ silent! call cycle#add_group(['red', 'blue', 'green', 'yellow']) ]]
    vim.cmd [[ silent! call cycle#add_group(['tiny', 'small', 'medium', 'big', 'huge']) ]]
    vim.cmd [[ silent! call cycle#add_group(['debug', 'info', 'warn', 'error', 'silent']) ]]
    vim.cmd [[ silent! call cycle#add_group(['x-short', 'short', 'normal', 'medium', 'long', 'large', 'x-large']) ]]
    vim.cmd [[ silent! call cycle#add_group(['pico', 'nano', 'micro', 'mili', 'kilo', 'mega', 'giga', 'tera', 'peta']) ]]
    vim.cmd [[ silent! call cycle#add_group(['sunday', 'monday', 'tuesday', 'wensday', 'thursday', 'friday', 'saturday']) ]]
  end
})

return M
