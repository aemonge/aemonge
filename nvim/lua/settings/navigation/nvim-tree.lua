-----------------------------------------------------------------------------------------------------------------
--                                                   NVimTree                                                   |
-----------------------------------------------------------------------------------------------------------------
local M = {}

table.insert(M, {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    ft = require("file-types")({
        "text",
        "markup",
        "languages",
        "frameworks",
    }),
    config = function()
        local function on_attach(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- IO operations
            vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
            vim.keymap.set('n', 'D', api.fs.remove, opts('Delete'))
            vim.keymap.set('n', 'd', api.fs.trash, opts('Trash'))
            vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
            -- vim.keymap.set('n', 'e', api.fs.rename_node, opts('Rename: Basename')) -- TODO: Verify
            -- vim.keymap.set('n', 'e', api.fs.rename_sub, opts('Rename: Absolute Path'))
            vim.keymap.set('n', 'e', api.fs.rename, opts('Rename'))
            vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
            vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
            vim.keymap.set('n', 'Y', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
            vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
            vim.keymap.set('n', 'K', api.node.show_info_popup, opts('Info'))

            -- Tree Exploring
            vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
            vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
            vim.keymap.set('n', 'r', api.tree.reload, opts('Refresh'))
            vim.keymap.set('n', 'z', api.tree.collapse_all, opts('Collapse'))
            vim.keymap.set('n', 'Z', api.tree.expand_all, opts('Expand All'))
            vim.keymap.set('n', 'u', api.node.navigate.parent, opts('Parent Directory'))
            vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))

            -- File navigation
            vim.keymap.set('n', '/', api.tree.search_node, opts('Search'))
            vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
            vim.keymap.set('n', '<CR>', api.node.open.no_window_picker, opts('Open: No Window Picker'))
            vim.keymap.set('n', 't', api.node.open.tab, opts('Open: Tab'))
            vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
            vim.keymap.set('n', 'S', api.node.open.horizontal, opts('Open: Horizontal Split'))

            -- Filter and Command
            vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
            vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
            vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))

            -- Toggle Mappers
            vim.keymap.set('n', 'i', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
            vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            vim.keymap.set('n', 'u', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
            vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))

            -- Default mappings.
            vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
            vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
            vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))

            -- You might tidy things by removing these along with their default mapping.
            vim.keymap.set('n', 'O', '', { buffer = bufnr })
            vim.keymap.del('n', 'O', { buffer = bufnr })
            vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
            vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
            vim.keymap.set('n', '<2-LeftMouse>', '', { buffer = bufnr })
            vim.keymap.del('n', '<2-LeftMouse>', { buffer = bufnr })
            vim.keymap.set('n', 'D', '', { buffer = bufnr })
            vim.keymap.del('n', 'D', { buffer = bufnr })
            vim.keymap.set('n', 'E', '', { buffer = bufnr })
            vim.keymap.del('n', 'E', { buffer = bufnr })
        end

        require("nvim-tree").setup({
            on_attach = on_attach,
            sort_by = "case_sensitive",
            view = {
                adaptive_size = true,
                width = {
                    max = 40,
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
                    quit_on_open = true,
                },
            },
        })

        require("which-key").register({
            e = { ":NvimTreeFindFileToggle! <cr>", "NvimTree" },
        }, {
            mode = "n",
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        })
    end,
})

return M
