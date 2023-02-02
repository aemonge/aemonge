--------------------------------------------------------------------------------------------------------------------------
--                                                         CMP                                                           |
--------------------------------------------------------------------------------------------------------------------------
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
      show_prediction_strength = false
    })
  end
})

-------------------------------------------------------
-- Plugins
-------------------------------------------------------
-- table.insert(M, { "hrsh7th/cmp-buffer", event = "InsertEnter" })
-- table.insert(M, { "hrsh7th/cmp-path", event = "InsertEnter" })
table.insert(M, { "hrsh7th/cmp-cmdline", event = "InsertEnter" })
table.insert(M, { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" })
table.insert(M, { "rafamadriz/friendly-snippets", event = "InsertEnter" })
table.insert(M, { "onsails/lspkind.nvim", event = "InsertEnter" })
table.insert(M, { "L3MON4D3/LuaSnip", event = "InsertEnter" })
table.insert(M, { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" })
table.insert(M, { 'tzachar/fuzzy.nvim',
  dependencies = {'nvim-telescope/telescope-fzf-native.nvim'}
})
table.insert(M, { 'tzachar/cmp-fuzzy-buffer', event = "InsertEnter",
  dependencies = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'}
})
table.insert(M, { 'tzachar/cmp-fuzzy-path',  event = "InsertEnter",
  dependencies = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'}
})
table.insert(M, { "ray-x/cmp-treesitter", event = "InsertEnter" })
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
    "hrsh7th/cmp-cmdline",
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
        completion = {
          winhighlight = 'FloatBorder:Normal,CursorLine:Visual,Search:None',
          col_offset = -3,
          side_padding = 0,
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"

          return kind
        end,
      },
      sources = {
        { name = "cmp_tabnine", keyword_length = 0 },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = 'treesitter', keyword_length = 1 },
        { name = "luasnip", keyword_length = 2 },
        { name = 'fuzzy_buffer', keyword_length = 2 },

        { name = 'fuzzy_path', keyword_length = 1 },
        { name = "cmdline", keyword_length = 1 },
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
    -- cmp.event:on(
    --   'confirm_done',
    --   require('nvim-autopairs.completion.cmp').on_confirm_done()
    -- )
  end
})

return M
