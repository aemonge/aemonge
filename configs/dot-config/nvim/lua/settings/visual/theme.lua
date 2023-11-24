-------------------------------------------------------------------------
--                           Theme 🎨                                   |
-------------------------------------------------------------------------
local M = {}
---------------------------------------------------------------------------
--  Theme: https://github.com/EdenEast/nightfox.nvim
--  Font : Meslo-LGMDZ or ...
--             (Hack, Cousine, DroidSans-Mono-Nerd-Font, InconsolataLGC)
---------------------------------------------------------------------------
table.insert(M, {
    "EdenEast/nightfox.nvim",
    priority = 99999,
    config = function()
        require('nightfox').setup({
            options = {
                transparent = true,     -- Disable setting background
                terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                dim_inactive = false,   -- Non focused panes set to alternative background
                inverse = {             -- Inverse highlight for different types
                    match_paren = false,
                    search = false,
                },
                modules = {
                    -- List of various plugins and additional options
                    coc = true,
                    ['dap-ui'] = true,
                    diagnostic = true,
                    gitgutter = true,
                    gitsigns = true,
                    glyph_palette = true,
                    hop = true,
                    illuminate = true,
                    ['lazy.nvim'] = true,
                    lsp_saga = true,
                    lsp_trouble = true,
                    modes = true,
                    native_lsp = true,
                    navic = true,
                    neotree = true,
                    notify = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    whichkey = true,
                },
            },
            groups = {
                all = {
                    CursorColumn       = { bg = "NONE", style = "bold" },
                    CursorLine         = { bg = "NONE", style = "bold" },
                    CursorLineNr       = { fg = "NONE", style = "bold" },
                    FloatShadowThrough = { bg = "NONE" },
                    Folded             = { bg = "NONE" },
                    NonText            = { bg = "NONE" },
                    Normal             = { bg = "NONE" },
                    NormalFloat        = { bg = "NONE" },
                    -- NormalNC           = { bg = "NONE", fg = "#7e8188" },
                    Pmenu              = { bg = "NONE" },
                    Terminal           = { bg = "NONE" },
                    lualine_b_normal   = { bg = "#232831" },
                    lualine_c_normal   = { bg = "#232831" },
                    DiffAdd            = { bg = "NONE" },
                    DiffDelete         = { bg = "NONE" },
                    DiffChange         = { bg = "NONE" },
                    DiffText           = { bg = "NONE" },
                }
            }
        })
        vim.cmd('colorscheme nordfox')
        vim.cmd [[
      hi WhichKeyFloat blend=15
    ]]
        -- vim.opt.guicursor = "n-v-c-sm:ver25,i-ci-ve:ver25,r-cr-o:hor20"
    end
})

return M
