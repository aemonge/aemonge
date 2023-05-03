local function find_pyproject_toml()
  local handle = io.popen("find . -type f -name 'pyproject.toml' -print -quit 2> /dev/null")
  local result = handle:read("*a")
  handle:close()
  local path = result:match("^%s*(.-)%s*$")
  if path and #path > 0 then
    return path
  else
    return nil
  end
end

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
      builtin = null_ls.builtins.formatting.isort,
      executable = "isort"
    },
    {
      builtin = null_ls.builtins.formatting.black,
      executable = "black"
    },
    -- {
    --   builtin = null_ls.builtins.diagnostics.pylint,
    --   executable = "pylint",
    --   -- args = { "--rcfile", find_pyproject_toml() or "" }
    -- },
    {
      builtin = null_ls.builtins.diagnostics.mypy,
      executable = "mypy",
    },
    -- {
    --   builtin = null_ls.builtins.diagnostics.pydocstyle,
    --   executable = "pydocstyle"
    -- },
    {
      builtin = null_ls.builtins.diagnostics.flake8,
      executable = "flake8"
    },
    -- { // Not all flake8 plugins support pyproject
    --   builtin = null_ls.builtins.diagnostics.flake8,
    --   executable = "pyproject-flake8"
    -- },
    -- {
    --   builtin = null_ls.builtins.diagnostics.vulture,
    --   executable = "vulture"
    -- },
  }

  for _, item in ipairs(builtins_and_executables) do
    local path = get_virtual_path(item.executable)
    if path then
      local config = { command = path }
      if item.args then
        config.args = item.args
      end
      table.insert(sources, item.builtin.with(config))
    end
  end

  return sources
end

return get_python_sources
