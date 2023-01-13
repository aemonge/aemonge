--------------------------------------------------------------------------------------------------------------------------
--                                                  🗒️ Todo's                                                            |
--------------------------------------------------------------------------------------------------------------------------
-- TODO: Clean Out the documentation section, and add a Index to navigate
-- TODO: Wipe-out all buffer, even if there more than a terminal open, but all in the same tab.
-- TODO: Accept suggestion with <C-k>
-- TODO: Wait for a Vimade fix
-- TODO: Configure the DAP
-- TODO: Which keymap:
  -- For navigation Search the Visual mappings
  -- For Terminal emulate the split behavior form navigation to split terminals, and remove the hard vs soft term
  -- For code actions
  -- The rest
-- TODO: BUG: Fix the terminal functions and local mappings
-- TODO: Properly load the files with:  require, dofile, or loadfile
-- TODO: How to set it through <Plug>, since it seams to be the convention
-- TODO: On Experimental, do the TODO for scratch

--------------------------------------------------------------------------------------------------------------------------
--                                                  🌚 Index                                                             |
--------------------------------------------------------------------------------------------------------------------------
--  0. General - Settings, Lunar-Vim Overwrites and which key - (./settings/general.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/general.config.lua')

--  1. Quick Smart Mappings  - (./settings/mini-plugins.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/mini-plugins.config.lua')

--  2. Theming - (./settings/theme.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/theme.config.lua')

--  3. Visual Aids - (./settings/visual-aids.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/visual-aids.config.lua')

--  4. Navigation, Motions, and Search - (./settings/navigation.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/navigation.config.lua')

--  5. Terminal - (./settings/terminal.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/terminal.config.lua')

--  6. Code History - Undo and Git (./settings/code-history.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/code-history.config.lua')

--  6. Code Actions - Comment, Format, Editor-config, and Project - (./settings/code-actions.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/code-actions.config.lua')

--  7. Code Analysis - Lint, Todos, Helpers and Tag-Search - (./settings/code-analysis.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/code-analysis.config.lua')

--  8. Code Debug - DAP, console.logs, enable line interpreters and quick code run. (./settings/code-debug.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/code-debug.config.lua')

--  9. Completion - LSP, Treesitter, snippets, Emoji and Tab-Nine (AI) - (./settings/code-completion.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/code-completion.config.lua')

-- 10. Hipster and Third-party - Emoji, glow, and ghost text - (./settings/third-party.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/third-party.config.lua')

-- 11. Code new languages and frameworks - (./settings/frameworks.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/frameworks.config.lua')

-- 12. Experimental / Erroneous or crazy slow (./settings/experimental.config.lua)
dofile('/Users/aemonge/.config/lvim/settings/experimental.config.lua')

-- 13. Experimental / Erroneous or crazy slow (./settings/lunar-vim-config-docs.lua)

--------------------------------------------------------------------------------------------------------------------------
--                                                 📚 Documentation                                                      |
--------------------------------------------------------------------------------------------------------------------------
--[[
  use {
    'myusername/example',        -- The plugin location string
    -- The following keys are all optional
    disable = boolean,           -- Mark a plugin as inactive
    as = string,                 -- Specifies an alias under which to install the plugin
    installer = function,        -- Specifies custom installer. See "custom installers" below.
    updater = function,          -- Specifies custom updater. See "custom installers" below.
    after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
    rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
    opt = boolean,               -- Manually marks a plugin as optional.
    bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
    branch = string,             -- Specifies a git branch to use
    tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
    commit = string,             -- Specifies a git commit to use
    lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
    run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
    requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
    rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
    config = string or function, -- Specifies code to run after this plugin is loaded.
    -- The setup key implies opt = true
    setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
                                 -- the plugin is waiting for other conditions (ft, cond...) to be met.
    -- The following keys all imply lazy-loading and imply opt = true
    cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
    ft = string or list,         -- Specifies filetypes which load this plugin.
    keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
    event = string or list,      -- Specifies autocommand events which load this plugin.
    fn = string or list          -- Specifies functions which load this plugin.
    cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
    module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
                                 -- with one of these module names, the plugin will be loaded.
    module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
                                 -- requiring a string which matches one of these patterns, the plugin will be loaded.
  }
]]
