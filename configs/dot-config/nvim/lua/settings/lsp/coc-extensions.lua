local M = {}

M.list = {
    ["python"] = {
        "coc-pyright",
    },

    ["backend"] = {
        "coc-sumneko-lua",
    },

    ["frontend"] = {
        "coc-css",
        "coc-html",
        "coc-svelte",
        "coc-prettier",
        "coc-tsserver",
    },

    ["databases"] = {
    },

    ["devops"] = {
        "coc-sh",
        "coc-docker",
        "@yaegassy/coc-nginx",
    },

    ["text_markdowns"] = {
        "coc-yaml",
        "coc-markdownlint",
        "coc-json",
        "coc-toml",
        "coc-markdown-preview-enhanced",
    },

    ["tools_extensions"] = {
        "coc-snippets",
        "coc-pairs",
        "coc-diagnostic",
        "coc-vimlsp",
        "coc-marketplace",
        "coc-project",
        "coc-highlight",
        "coc-nav",
        "coc-grammarly"
    },
}

return M
