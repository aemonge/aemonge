function ClearTerm()
  vim.opt_local.scrollback = 1

  vim.api.nvim_command("startinsert")
  vim.api.nvim_feedkeys("clear", 't', false)
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

function NewTermTab(active)
  vim.api.nvim_command(":tabnew")
  StartTerm(0)
end

function StartTerm(first)
  vim.api.nvim_command("terminal")
  vim.cmd("setlocal bufhidden=delete")
  if first == 1 then
    vim.cmd[[set laststatus=0]]
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
end
