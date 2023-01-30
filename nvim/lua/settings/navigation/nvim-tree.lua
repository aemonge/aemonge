--------------------------------------------------------------------------------------------------------------------------
--                                                     NVimTree                                                          |
--------------------------------------------------------------------------------------------------------------------------
local M = {}

table.insert(M, { "nvim-tree/nvim-tree.lua", 
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function ()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        adaptive_size = true,
        width = 40,
        mappings = {
          list = {
            -- IO.File operations
            { key = "c", action = "copy.node" },
            { key = "D", action = "remove" },
            { key = "a", action = "create" },
            { key = "d", action = "trash" },
            { key = "e", action = "full_rename" },
            { key = "p", action = "paste" },
            { key = "x", action = "cut" },

            -- Tree View Settings
            { key = "C", action = "cd" },
            { key = "q", action = "close" },
            { key = "r", action = "refresh" },
            { key = "z", action = "collapse_all" },
            { key = "u", action = "dir_up" },
            { key = "m", action = "toggle_mark" },

            -- Motions
            -- { key = "/", action = "search_node" },
            -- { key = "H", action = nil },

            -- Opening Actions
            { key = 't', action = "tabnew" },
            { key = { "<CR>", "o" }, action = "edit_no_picker", mode = "n" },
            { key = "Z", action = "expand_all" },
            { key = "s", action = "split" },
            { key = "S", action = "vsplit" },

            -- Copy actions
            { key = "Y",  action = "copy_path" },
            { key = "gy", action = "copy_absolute_path" },
            { key = "y",  action = "copy_name" },

            -- Default settings: Toggles
            { key = "<c-f>",  action = "telescope_find_files" },
            { key = "f", action = "live_filter" },
            { key = ".", action = "run_file_command" },
            { key = "U", action = "toggle_custom" },
            { key = "I", action = "toggle_dotfiles" },
            { key = "<C-k>", action = "toggle_file_info" },
            { key = "i", action = "toggle_git_ignored" },
            { key = "M", action = "toggle_mark" }
          }
        },
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      actions = {
        open_file = {
          quit_on_open = true
        }
      }
    })

    require "which-key".register({
      e = { ":NvimTreeToggle <cr>" , "NvimTree"}
    }, {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    })
  end
})

return M
