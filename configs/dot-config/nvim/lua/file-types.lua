local pluginsFileTypes = {
    "NvimTree",     -- NvimTree
    "Telescope",    -- Telescope.nvim
    "WhichKey",     -- WhichKey.nvim
    "ale",          -- ALE
    "checkhealth",  -- Health Check
    "coc-explorer", -- coc-explorer
    "colorscheme",  -- Colorscheme
    "dashboard",    -- dashboard-nvim
    "db_ui",        -- DBUI
    "defx",         -- Defx
    "floaterm",     -- vim-floaterm
    "fugitive",     -- vim-fugitive
    "fzf",          -- FZF
    "help",         -- Help
    "lspconfig",    -- LSPConfig
    "lspinfo",      -- LSP Info
    "lspinstall",   -- LSP Install
    "man",          -- Manpage
    "neoterm",      -- neoterm
    "nerdtree",     -- NERDTree
    "netrw",        -- netrw
    "packer",       -- Packer.nvim
    "qf",           -- Quickfix
    "scratch",      -- Scratch buffer
    "startify",     -- vim-startify
    "symbols",      -- symbols-outline
    "tagbar",       -- Tagbar
    "tsplayground", -- Treesitter Playground
    "undotree",     -- undotree
    "vim-plug",     -- vim-plug
    "vista",        -- vista.vim
    "terminal",     -- terminal
}

local dapFileTypes = {
    "DAP Scopes", "DAP Scopes", "DAP Stacks", "DAP Watches",
    "DAP Console", "*dap-repl*"
}

local textFileTypes = {
    "txt",
    "text",
    "plain",
    "log",
    "rtf",
    "email",
    "msg",
}

local markupFileTypes = {
    "markdown",
    "md",
    "asciidoc",
    "adoc",
    "rst",
    "org",
    "creole",
    "mediawiki",
    "dokuwiki",
    "latex",
    "tex",
    "pdf",
    "odt",
    "doc",
    "docx",
    "epub",
    "mobi",
    "csv",
    "tsv",
    "bib",
    "bibtex",
    "yaml",
    "yml",
    "json",
    "xml",
    "html",
    "xhtml",
    "htm",
    "css",
    "scss",
    "sass",
    "less",
    "styl",
    "ini",
    "conf",
    "properties",
    "plist",
    "toml",
    "eml",
    "xquery",
    "xslt",
}

local languageFileTypes = {
    "bash",
    "sh",
    "zsh",
    "javascript",
    "python",
    "coffee",
    "java",
    "quarto",
    "bash",
    "c",
    "cpp",
    "cs",
    "go",
    "swift",
    "ruby",
    "php",
    "kotlin",
    "typescript",
    "dart",
    "haskell",
    "scala",
    "perl",
    "groovy",
    "lua",
    "r",
    "rust",
    "elixir",
    "erlang",
    "julia",
    "powershell",
    "shell",
    "assembly",
    "fsharp",
    "clojure",
    "cobol",
    "pascal",
    "objective-c",
    "d",
    "fortran",
    "racket",
    "elm",
    "crystal",
    "ocaml",
    "nix",
    "idris",
    "prolog",
    "ada",
    "ballerina",
    "nim",
    "reason",
    "agda",
    "haxe",
    "zephir",
    "vhdl",
    "verilog",
    "tcl",
    "awk",
    "sed",
    "sql",
    "graphql",
}

local frameworkFileTypes = {
    "dockerfile",
    "cmake",
    "makefile",
    "ros",
    "react",
    "angular",
    "vue",
    "django",
    "flask",
    "rails",
    "laravel",
    "spring",
    "express",
    "aspnet",
    "drupal",
    "wordpress",
    "symfony",
    "ember",
    "backbone",
    "meteor",
    "aurelia",
    "svelte",
}

local dataFileTypes = {
    "csv",
    "tsv",
    "json",
    "xml",
    "yaml",
    "yml",
    "hdf5",
    "netcdf",
    "parquet",
    "avro",
    "pickle",
    "mat",
}

local versionControlFileTypes = {
    "git",
    "diff",
    "gitcommit",
    "gitconfig",
    "gitignore",
    "gitmodules",
    "gitattributes",
    "gitmessage",
    "gitrebase",
    "gittodo",
    "svn",
    "hg",
    "mercurial",
    "cvs",
}

local allFileTypes = {
    text           = textFileTypes,
    markup         = markupFileTypes,
    languages      = languageFileTypes,
    frameworks     = frameworkFileTypes,
    data           = dataFileTypes,
    versionControl = versionControlFileTypes,
    plugings       = pluginsFileTypes,
    dap            = dapFileTypes
}

local function getFileTypes(categories)
    local result = {}
    for _, category in ipairs(categories) do
        local fileTypes = allFileTypes[category]
        if fileTypes then
            for _, fileType in ipairs(fileTypes) do
                table.insert(result, fileType)
            end
        end
    end
    return result
end

return getFileTypes

-- "text",
-- "markup",
-- "languages",
-- "frameworks",
-- "data",
-- "versionControl",
-- "plugings",
-- "dap"
