local M = {}

table.insert(M, {
    "monaqa/dial.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local wk = require("which-key")
        local dialM = require("dial.map")

        -- Register key mappings
        local key_mappings = {
            n = {
                ['<c-a>'] = { dialM.inc_normal(), "Dial Inc" },
                ['<c-x>'] = { dialM.dec_normal(), "Dial Dec" }
            },
            v = {
                ['<c-a>'] = { dialM.inc_visual(), "Dial Inc" },
                ['<c-x>'] = { dialM.dec_visual(), "Dial Dec" }
            }
        }

        for mode, mappings in pairs(key_mappings) do
            wk.register(mappings, { mode = mode, silent = true, noremap = true, nowait = true })
        end

        -- Define custom augends
        local custom_augends = {
            { "set", "get" }, { "form", "to" }, { "push", "pop" }, { "more", "less" },
            { "mas", "menos" }, { "prev", "next" }, { "start", "end" }, { "true", "false" },
            { "light",  "dark" }, { "open", "close" }, { "read", "write" }, { "truthy", "falsy" },
            { "weight", "height" }, { "filter", "reject" }, { "disable", "enable" },
            { "const", "let",   "var" }, { "disabled", "enabled" }, { "internal", "external" },
            { "floor", "round", "ceil" }, { "subscribe", "unsubscribe" }, { "header", "body", "footer" },
            { "protected", "private", "public" }, { "red", "blue", "green", "yellow" },
            { "tiny",      "small",   "medium", "big", "huge" }, { "debug", "info", "warn", "error", "silent" },
            { "x-short", "short",  "normal",  "medium",    "long",     "large",  "x-large" },
            { "pico",    "nano",   "micro",   "mili",      "kilo",     "mega",   "giga",    "tera", "peta" },
            { "sunday",  "monday", "tuesday", "wednesday", "thursday", "friday", "saturday" },
            { "import",  "export" }, { "require", "provide" }, { "async", "await" },
            { "public",    "private", "protected" },
            { "front-end", "back-end" }, { "client", "server" },
            { "staging", "production", "development" },
            { "docker",  "kubernetes", "terraform" },
            { "get",     "post",       "put",        "delete", "patch" },
            { "http",    "https" }, { "ipv4", "ipv6" },
            { "tcp",  "udp" }, { "dev", "prod" },
            { "pull", "commit", "push" }, { "branch", "tag", "commit" },
            { "feature",    "bug",        "refactor" }, { "merge", "rebase" },
            { "javascript", "typescript", "html",    "css" }, { "vue", "react", "angular", "svelte" },
            { "yaml", "json", "xml" }, { "sql", "nosql" },
            { "npm",  "yarn" }, { "webpack", "rollup", "parcel" }
        }

        local augend = require("dial.augend")
        local custom_dial_augends = {}
        for _, elements in ipairs(custom_augends) do
            table.insert(custom_dial_augends, augend.constant.new { elements = elements })
        end

        require("dial.config").augends:register_group {
            default = custom_dial_augends
        }
    end
})

return M
