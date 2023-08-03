local M = {}

M.list = {
    ["python"] = {
        "coc-pyright",
        -- "coc-black-formatter",
        -- "coc-mypy"
    },

    ["backend"] = {
        "coc-lua",
        -- "coc-stylua",
        "coc-sumneko-lua",
        "coc-clangd",
    },

    ["frontend"] = {
        "coc-css",
        "coc-html",
        "coc-prettier",
        "coc-stylelint",
        "coc-tsserver",
    },

    ["databases"] = {
        "coc-sql",
    },

    ["devops"] = {
        "coc-sh",
        "coc-docker",
        "@yaegassy/coc-nginx",
    },

    ["text_markdowns"] = {
        "coc-yaml",
        "coc-markdownlint",
        "coc-eslint",
        "coc-json",
        "coc-toml",
        "coc-markdown-preview-enhanced",
        "coc-esbonio",
    },

    ["tools_extensions"] = {
        "coc-snippets",
        "coc-tabnine",
        "coc-pairs",
        "coc-spell-checker",
        "coc-diagnostic",
        "coc-vimlsp",
    },
}

return M
