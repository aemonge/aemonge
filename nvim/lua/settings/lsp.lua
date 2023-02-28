local M = {}

-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/advance-usage.md#intergrate-with-null-ls

local hover = require("settings.lsp.hover")
table.insert(M, hover)

local ufo = require("settings.lsp.nvim-ufo")
table.insert(M, ufo)

local lspzero = require "settings.lsp.lsp-zero"
table.insert(M, lspzero)

local otter = require "settings.lsp.otter"
table.insert(M, otter)

local signature = require "settings.lsp.signature"
table.insert(M, signature)

local lspconfig = require "settings.lsp.lspconfig"
table.insert(M, lspconfig)

return M
