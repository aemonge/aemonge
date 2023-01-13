--------------------------------------------------------------------------------------------------------------------------
--                                                      Theme 🎨                                                         |
--------------------------------------------------------------------------------------------------------------------------
-- NOTE: [nerd-fonts](https://www.nerdfonts.com/font-downloads)
--       Recommended to Use: *DroidSans-Mono-Nerd-Font* or InconsolataLGC
lvim.transparent_window = true

---------------------------------------------------------------------------
--  Function
---------------------------------------------------------------------------
function SetTheme()
  vim.cmd[[
    hi clear SpellBad
    hi clear SpellCap
    hi SpellBad     gui=underline cterm=underline
    hi SpellCap     gui=underline cterm=underline
    hi CursorLine   gui=bold      cterm=bold    ctermbg=NONE    guibg=NONE
    hi CursorColumn gui=bold      cterm=bold    ctermbg=NONE    guibg=NONE
    hi SignColumn   gui=bold      cterm=bold    ctermbg=NONE    guibg=NONE
    hi NonText      ctermbg=NONE    guibg=NONE
    hi Terminal     ctermbg=NONE    guibg=NONE
    hi Normal       ctermbg=NONE    guibg=NONE
    hi Folded       ctermbg=NONE    guibg=NONE
  ]]
end
vim.api.nvim_create_autocmd("ColorScheme", {
  command = "lua SetTheme()"
})

---------------------------------------------------------------------------
--  Theme
---------------------------------------------------------------------------
table.insert(lvim.plugins, { "sainnhe/gruvbox-material" })
vim.g.gruvbox_material_contrast_dark = "medium"
vim.g.gruvbox_material_transparent_bg = 1
lvim.colorscheme = "gruvbox-material"

---------------------------------------------------------------------------
--  Lualine
---------------------------------------------------------------------------
lvim.builtin.lualine.options.disabled_buftypes = { 'terminal', 'quickfix', 'prompt' }
lvim.builtin.lualine.options.disabled_filetypes = { 'terminal' }
lvim.builtin.lualine.sections.lualine_c = {
  { "aerial" },
  { "chadtree" },
  { "fugitive" },
  { "pythonenv" },
  { "diff" },
  { "nvim-dap-ui" },
  { "nvim-tree" },
  { "filename",
    path = 1, shorting_target = 80
  }
}

lvim.builtin.lualine.options.icons_enabled = true
lvim.builtin.lualine.on_config_done = function(lualine)
  local config = lualine.get_config()
  table.insert(config.sections.lualine_x,  3, { "tabnine" })
  lualine.setup(config)
end
