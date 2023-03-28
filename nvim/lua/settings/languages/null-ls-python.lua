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

  local pylint_path = get_virtual_path("pylint")
  if pylint_path then
    table.insert(sources, null_ls.builtins.diagnostics.pylint.with({ command = pylint_path }))
  end

  local pydocstyle_path = get_virtual_path("pydocstyle")
  if pydocstyle_path then
    table.insert(sources, null_ls.builtins.diagnostics.pydocstyle.with({ command = pydocstyle_path }))
  end

  local flake8_path = get_virtual_path("flake8")
  if flake8_path then
    table.insert(sources, null_ls.builtins.diagnostics.flake8.with({ command = flake8_path }))
  end

  local pyproject_flake8_path = get_virtual_path("pyproject-flake8")
  if pyproject_flake8_path then
    table.insert(sources, null_ls.builtins.diagnostics.flake8.with({ command = pyproject_flake8_path }))
  end

  local vulture_path = get_virtual_path("vulture")
  if vulture_path then
    table.insert(sources, null_ls.builtins.diagnostics.vulture.with({ command = vulture_path }))
  end

  return sources
end

return get_python_sources
