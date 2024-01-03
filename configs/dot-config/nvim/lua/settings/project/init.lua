local M = {
    "ahmedkhalf/project.nvim",
    priority = 100 - 1,
    config = function()
        require("project_nvim").setup({
            patterns = {
                ".inputrc", ".zshrc", ".babelrc", ".bash_profile", ".bashrc", ".browserslistrc",
                ".bzr", ".condarc", ".editorconfig", ".env", ".eslintignore", ".eslintrc.js",
                ".eslintrc.json", ".flake8", ".flake8", ".git", ".gitconfig", ".hg", ".htmlhintrc",
                ".lein", ".markdownlint.jsonc", ".nvmrc", ".pdbrc", ".prettierrc", ".pylintrc", ".rbenv-gemsets",
                ".ruby-version", ".selenarc.toml", ".stylelintrc", ".svn", ".vuepress", "AndroidManifest.xml", "Gemfile",
                "Info.plist", "Makefile", "Pipfile", "README.md", "README.rst", "Rakefile", "Script", "_darcs", "a.toml",
                "angular.json", "app/", "build.gradle", "build.sbt", "build.yaml", "cargo.toml", "composer.json",
                "csharp.csproj",
                "csharp.sln", "deps.edn", "environment.yml", "gatsby-config.js", "git", "go.mod", "gradle.properties",
                "gradlew",
                "ipython_config.py", "karma.conf.js", "mix.exs", "next.config.js", "package.json", "package.json",
                "pgcli.config",
                "postcss.config.js", "project.clj", "pyproject.toml", "requirements.t", "requirements.txt",
                "settings.gradle",
                "setup.cfg", "setup.py", "src/", "stylu", "stylua.toml", "stylua.toml", "terminalrc", "tox.ini",
                "tsconfig.json",
                "webpack.config.js", "xt",
            },
        })
        require('telescope').load_extension('projects')
    end,
}

return M
