local utils = require "core.utils"
local navic = require "nvim-navic"
local navbuddy = require "nvim-navbuddy"
local illuminate = require "illuminate"

local M = {}

M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    navbuddy.attach(client, bufnr)
  end

  illuminate.on_attach(client)
end

M.capabilities =  require("plugins.configs.lspconfig").capabilities

return M
