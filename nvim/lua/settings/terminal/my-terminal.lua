local t_mappings = {}

local function t(str) --TermCodes
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end
---------------------------------------------------------------------------
--  Functions Helpers
---------------------------------------------------------------------------
function ClearTerm(reset)
  vim.opt_local.scrollback = 1
  -- vim.o.scrollback = 1

  vim.api.nvim_command("startinsert")
  if reset == 1 then
    vim.api.nvim_command("silent! BWipeout! hidden")
    vim.api.nvim_feedkeys("reset", 't', false)
  else
    vim.api.nvim_feedkeys("clear", 't', false)
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 't', true)

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

function TerminalLocalOpts()
  vim.opt_local.title = true
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.showcmd = false
  vim.opt_local.wrap = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldenable = false
  vim.opt_local.spell = false
  vim.opt_local.ruler = false
  vim.cmd [[
    nnoremap <buffer> <C-f> <C-W>gf
    nnoremap <buffer> q :startinsert<cr>q
    vnoremap <buffer> <C-f> <C-W>gf
    setlocal ft=terminal
  ]]
end

function NewTermTab(active)
  vim.api.nvim_command(":tabnew")
  StartTerm(0, active)
end

function OpenFileProject(args)
  for str in string.gmatch(args, "[^%s]+") do
    vim.cmd.tabe(str)
    vim.cmd(":LspRestart<cr>")
  end
end

function SplitTerm(horizontal, active)
  if horizontal == 1 then
    vim.api.nvim_command("split")
  else
    vim.api.nvim_command("vsplit")
  end
  StartTerm(0, active)
end

function StartTerm(first, active)
  vim.api.nvim_command("terminal")
  vim.cmd("setlocal bufhidden=delete")
  if first == 1 then
    -- NOTE: when only the term tab remains, clear all. To give the impression of closing vim.
    vim.api.nvim_create_autocmd("TermEnter", {
      callback = function()
        if vim.fn.tabpagenr('$') == 1 and #vim.fn.tabpagebuflist() == 1 then
          vim.cmd [[silent! BWipeout! other]]
        end
      end
    })
    vim.api.nvim_create_autocmd("TermClose", {
      callback = function()
        if vim.v.event.status == 0 then
          vim.cmd [[ q ]]
        end
      end
    })
  else
    vim.api.nvim_create_autocmd("TermClose", {
      callback = function()
        if vim.v.event.status == 0 then
          vim.cmd [[ exe 'silent! bdelete! '..expand('<abuf>')]]
        end
      end
    })
  end

  vim.api.nvim_command("startinsert")
  if active == 1 then
    vim.cmd [[ au BufEnter <buffer> :startinsert ]]
  end
end

vim.api.nvim_create_autocmd({"TermOpen"}, {
  callback = TerminalLocalOpts
})

table.insert(t_mappings, {
  ["<ESC><ESC>"] = { t '<C-\\><C-N>', "Go to normal mode" },
  -- ['<C-T>'] = { t '<C-\\><C-n>:lua NewTermTab(0)<cr>', "New soft-term tab" },

  ['<C-p>'] = { t 'nvr -cc "cd $(pwd) | Telescope find_files" <CR>', "Open files in CWD" },
  ['<C-t>'] = { t '<C-\\><C-n>:lua NewTermTab(1)<cr>', "New hard-term tab" },

  ['<C-l>'] = {
    name = "Cleaners",
    ['<C-l>'] = { [[<C-\><C-N>:lua ClearTerm(0)<CR>]], "Clear cmd" },
    ['<C-l><C-l>'] = { [[<C-\><C-N>:lua ClearTerm(1)<CR>]], "Clear and wipe history" }
  },
})

return t_mappings
