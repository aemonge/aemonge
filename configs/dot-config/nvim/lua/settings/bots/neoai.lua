local M = {}

table.insert(M, {
    "Bryley/neoai.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    cmd = {
        "NeoAI",
        "NeoAIOpen",
        "NeoAIClose",
        "NeoAIToggle",
        "NeoAIContext",
        "NeoAIContextOpen",
        "NeoAIContextClose",
        "NeoAIInject",
        "NeoAIInjectCode",
        "NeoAIInjectContext",
        "NeoAIInjectContextCode",
    },
    keys = {
        { "<leader>as", desc = "summarize text" },
        { "<leader>ag", desc = "generate git message" },
    },
    config = function()
        require("neoai").setup({
            ui = {
                output_popup_text = "NeoAI",
                input_popup_text = "Prompt",
                width = 30,               -- As percentage eg. 30%
                output_popup_height = 80, -- As percentage eg. 80%
                submit = "<c-g>",         -- Key binding to submit the prompt
            },
            models = {
                {
                    name = "openai",
                    model = "gpt-4-0613",
                    params = nil,
                },
            },
            register_output = {
                ["g"] = function(output)
                    return output
                end,
                ["c"] = require("neoai.utils").extract_code_snippets,
            },
            inject = {
                cutoff_width = 75,
            },
            prompts = {
                context_prompt = function(context)
                    return "Hey, I'd like to provide some context for future "
                        .. "messages. Here is the code/text that I want to refer "
                        .. "to in our upcoming conversations:\n\n"
                        .. context
                end,
            },
            mappings = {
                ["select_up"] = "<C-k>",
                ["select_down"] = "<C-j>",
            },
            open_ai = {
                api_key = {
                    env = "OPENAI_API_KEY",
                    value = nil,
                    -- `get` is is a function that retrieves an API key, can be used to override the default method.
                    -- get = function() ... end

                    -- Here is some code for a function that retrieves an API key. You can use it with
                    -- the Linux 'pass' application.
                    -- get = function()
                    --     local key = vim.fn.system("pass show openai/mytestkey")
                    --     key = string.gsub(key, "\n", "")
                    --     return key
                    -- end,
                },
            },
            shortcuts = {
                {
                    name = "textify",
                    key = "<leader>if",
                    desc = "fix text with neoAI",
                    use_context = true,
                    prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
                    modes = { "v" },
                    strip_function = nil,
                },
            },
        })
    end,
})

return M
