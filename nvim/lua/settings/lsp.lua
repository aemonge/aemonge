local M = {}

local lspzero = require "settings.lsp.lsp-zero"
table.insert(M, lspzero)

local otter = require "settings.lsp.otter"
table.insert(M, otter)

local signature = require "settings.lsp.signature"
table.insert(M, signature)

local lspconfig = require "settings.lsp.lspconfig"
table.insert(M, lspconfig)

return M
