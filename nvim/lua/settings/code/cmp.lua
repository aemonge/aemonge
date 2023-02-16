------------------------------------------------------------------------------------------------------------------
--                                                    CMP                                                        |
------------------------------------------------------------------------------------------------------------------
local M = {}

vim.opt.wildmode = { "longest:full", "full" }
vim.opt.completeopt = "longest,menuone,noselect,preview"

disabled = {}
-------------------------------------------------------
-- TabNine
-------------------------------------------------------
table.insert(M, { "tzachar/cmp-tabnine",
  build = "./install.sh",
  dependencies = "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  config = function()
    require('cmp_tabnine.config'):setup({
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = '..',
      show_prediction_strength = true
    })
  end
})

-------------------------------------------------------
-- Plugins
-------------------------------------------------------
-- table.insert(M, { "davidsierradz/cmp-conventionalcommits", ft = "gitcommit" })
table.insert(M, { "f3fora/cmp-spell"})
table.insert(M, { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" })
table.insert(M, { "rafamadriz/friendly-snippets", event = "InsertEnter" })
table.insert(M, { "onsails/lspkind.nvim", event = "InsertEnter" })
-- table.insert(M, { "L3MON4D3/LuaSnip", event = "InsertEnter" })
table.insert(M, { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" })
table.insert(M, { 'tzachar/fuzzy.nvim',
  dependencies = {'nvim-telescope/telescope-fzf-native.nvim'}
})
-- table.insert(M, { 'tzachar/cmp-fuzzy-buffer', event = "InsertEnter",
--   dependencies = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'}
-- })
-- table.insert(M, { 'tzachar/cmp-fuzzy-path',  event = "InsertEnter",
--   dependencies = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'}
-- })
table.insert(M, {"hrsh7th/cmp-path"})
-- table.insert(M, { "ray-x/cmp-treesitter", event = "InsertEnter" })
-------------------------------------------------------
-- Disabled
-------------------------------------------------------

-------------------------------------------------------
-- Load CMP
-------------------------------------------------------
table.insert(M, { "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",

    -- "hrsh7th/cmp-nvim-lsp",
    "tzachar/cmp-tabnine",

    'nvim-tree/nvim-web-devicons',
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require "cmp"
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')

    local source_mapping = {
      nvim_lsp = "[LSP]",
      cmp_tabnine = "[T9]",
      -- treesitter = "[TrStr]",
      nvim_lua = "[Snip]",
      path = "[Path]",
      buffer = "[Buffer]",
      spell = "[Spell]",
    }

    local check_backspace = function()
      local col = vim.fn.col "." - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    end

    local function next_sel(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end

    local function prev_sel(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),


        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },

        ["<C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- Start the autocomplete emtpy
        ["<C-k>"] = cmp.mapping.confirm { select = true },

        ["<Tab>"] = cmp.mapping(next_sel, { "i", "s", }),
        ["<C-n>"] = cmp.mapping(next_sel, { "i", "s", }),
        ["<C-p>"] = cmp.mapping(prev_sel, { "i", "s", }),
        ["<S-Tab>"] = cmp.mapping(prev_sel, { "i", "s", }),

        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      },

      window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered({
          winhighlight = 'FloatBorder:Normal,CursorLine:Visual,Search:None',
          scrollbar = false,
          completeopt = { "menuone", "preview", "noselect" } -- "longest,menuone,noselect,preview"
        }),
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol", maxwidth = 50})
          vim_item.menu = source_mapping[entry.source.name]
          if entry.source.name == "cmp_tabnine" then
            local detail = (entry.completion_item.data or {}).detail
            vim_item.kind = ""
          end
          return vim_item
        end
      },
      sources = {
        { name = "cmp_tabnine",
          priority = 100,
          keyword_length = 3,
          max_item_count = 5,
        },
        { name = "nvim_lsp",
          priority = 80,
          keyword_length = 1,
          -- entry_filter = function(entry, ctx)
          --   local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
          --   if kind == "Snippet" and ctx.prev_context.filetype == "java" then
          --     return false
          --   end
          --   if kind == "Text" then
          --     return false
          --   end
          --   return true
          -- end,
          -- keyword_pattern = [[^\s]]
        },
        -- { name = 'treesitter',
        --   priority = 50,
        --   max_item_count = 5,
        --   keyword_length = 2,
        --   -- keyword_pattern = [[^\s]]
        -- },
        { name = "luasnip",
          priority = 30,
          keyword_length = 2,
          max_item_count = 2,
          -- keyword_pattern = [[^\s]]
        },
        { name = 'buffer',
          priority = 10,
          keyword_length = 3,
          max_item_count = 5,
          option = {
            -- keyword_pattern = [[\k\+]],
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end
          }
        },
        { name = 'path',
          priority = 150,
          max_item_count = 10,
          keyword_length = 1,
        },
        { name = 'spell',
          priority = 5,
          keyword_length = 3,
          max_item_count = 3,
          option = {
            keep_all_entries = false,
            enable_in_context = function()
                return true
            end,
          },
        },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      view = {
        entries = "custom", selection_order = 'near_cursor'
      },
      experimental = {
        ghost_text = false
      },
    }
  end
})

return M
