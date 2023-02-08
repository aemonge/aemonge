local M = {}

table.insert(M, { "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      patterns = {
        ".env", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "requirements.txt",
        "Gemfile", "environment.yml", "README.rst", "README.md", "pyproject.toml", "tox.ini"
      }
    }
  end
})

return M
