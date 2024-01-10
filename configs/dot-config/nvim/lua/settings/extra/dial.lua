local M = {}

table.insert(M, {
    "monaqa/dial.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        -- Define custom augends
        local custom_augends = {
            { "set", "get" }, { "form", "to" }, { "push", "pop" }, { "more", "less" },
            { "mas", "menos" }, { "previous", "prev", "next" }, { "start", "end" }, { "true", "false" },
            { "light",  "dark" }, { "open", "close" }, { "read", "write" }, { "truthy", "falsy" },
            { "weight", "height" }, { "filter", "reject" }, { "disable", "enable" },
            { "const", "let",   "var" }, { "disabled", "enabled" }, { "internal", "external" },
            { "floor", "round", "ceil" }, { "subscribe", "unsubscribe" }, { "header", "body", "footer" },
            { "protected", "private",     "public" }, { "red", "blue", "green", "yellow" },
            { "tiny",      "extra-small", "small",   "medium",    "large",    "extra-large", "big",     "huge" },
            { "debug",     "info",        "warn",    "error",     "silent" },
            { "x-short",   "short",       "normal",  "medium",    "long",     "large",       "x-large" },
            { "pico",      "nano",        "micro",   "mili",      "kilo",     "mega",        "giga",    "tera", "peta" },
            { "sunday",    "monday",      "tuesday", "wednesday", "thursday", "friday",      "saturday" },
            { "import",    "export" }, { "require", "provide" }, { "async", "await" },
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


        -- Utility function to capitalize a string: true/false True/False TRUE/FALSE
        local function capitalize(s)
            return s:sub(1, 1):upper() .. s:sub(2):lower()
        end

        local expanded_custom_augends = {}

        for _, set in ipairs(custom_augends) do
            local lowercase_set, uppercase_set, capitalized_set = {}, {}, {}
            for _, word in ipairs(set) do
                table.insert(lowercase_set, word:lower())
                table.insert(uppercase_set, word:upper())
                table.insert(capitalized_set, capitalize(word))
            end
            table.insert(expanded_custom_augends, lowercase_set)
            table.insert(expanded_custom_augends, uppercase_set)
            table.insert(expanded_custom_augends, capitalized_set)
        end

        local augend = require("dial.augend")
        local custom_dial_augends = {}

        for _, elements in ipairs(expanded_custom_augends) do
            table.insert(custom_dial_augends, augend.constant.new { elements = elements })
        end

        require("dial.config").augends:register_group {
            default = custom_dial_augends
        }
    end,
    keys = {
        {
            '<c-a>',
            function() require("dial.map").manipulate("increment", "normal") end,
            { noremap = true, silent = true, nowait = true },
            mode = "n",
            desc = "Increment"
        },
        {
            '<c-x>',
            function() require("dial.map").manipulate("decrement", "normal") end,
            { noremap = true, silent = true, nowait = true },
            mode = "n",
            desc = "Decrement"
        },
        -- {
        --     '<c-a>',
        --     function() require("dial.map").manipulate("increment", "insert") end,
        --     { noremap = true, silent = true, nowait = true },
        --     mode = "i",
        --     desc = "Increment"
        -- },
        -- {
        --     '<c-x>',
        --     function() require("dial.map").manipulate("decrement", "insert") end,
        --     { noremap = true, silent = true, nowait = true },
        --     mode = "i",
        --     desc = "Decrement"
        -- },
    }

})

return M
