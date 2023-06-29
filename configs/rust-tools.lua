local on_attach = require("custom.utils.lsputils").on_attach
local capabilities = require("custom.utils.lsputils").capabilities
local M = {}

M.options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    -- settings = {
    --   ["rust-analyzer"] = {
    --     rustfmt = {
    --       extraArgs = {
    --         "--config",
    --         "max_width=80",
    --       },
    --     },
    --   },
    -- },
  },
}

return M
