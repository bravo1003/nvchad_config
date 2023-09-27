local on_attach = require("custom.utils.lsputils").on_attach
local capabilities = require("custom.utils.lsputils").capabilities
local lspconfig = require "lspconfig"
local lsputils = require "lspconfig/util"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "taplo", "yamlls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Setup lua server
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- Setup Clangd server
local clangd_bin = vim.fn.stdpath "data" .. "/mason/bin/clangd"
local cmd = {
  clangd_bin,
  "--background-index",
  "-j=4",
  "--all-scopes-completion",
  -- "--completion-style=detailed",
  "--header-insertion=never",
  "--clang-tidy",
  "--suggest-missing-includes",
  "--offset-encoding=utf-16",
  "--pch-storage=disk",
  "--malloc-trim",
}

if vim.fn.stridx(vim.fn.getcwd(), "work/tvsdk") >= 0 then
  table.insert(cmd, "--compile-commands-dir=/home/jliu/work/chromium/src/out_gn_aml-t962d4/Release/")
end

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = cmd,
  root_dir = lsputils.root_pattern("compile_commands.json", ".git"),
}

-- Setup Gopls server
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filestypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lsputils.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}
