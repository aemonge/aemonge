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

local function get_python_sources()
  local null_ls = require("null-ls")
  local sources = {}

  local builtins_and_executables = {
    {
      builtin = null_ls.builtins.formatting.autopep8,
      executable = "autopep8"
    },
    {
      builtin = null_ls.builtins.formatting.black,
      executable = "black"
    },
    {
      builtin = null_ls.builtins.diagnostics.pylint,
      executable = "pylint"
    },
    {
      builtin = null_ls.builtins.diagnostics.pydocstyle,
      executable = "pydocstyle"
    },
    {
      builtin = null_ls.builtins.diagnostics.flake8,
      executable = "flake8"
    },
    {
      builtin = null_ls.builtins.diagnostics.flake8,
      executable = "pyproject-flake8"
    },
    {
      builtin = null_ls.builtins.diagnostics.vulture,
      executable = "vulture"
    },
  }

  for _, item in ipairs(builtins_and_executables) do
    local path = get_virtual_path(item.executable)
    if path then
      table.insert(sources, item.builtin.with({ command = path }))
    end
  end

  return sources
end

return get_python_sources
