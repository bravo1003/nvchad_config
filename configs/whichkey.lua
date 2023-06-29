local wk_ok, wk = pcall(require, "which-key")

if wk_ok then
  wk.register {
    ["<leader>"] = {
      c = { name = "+Context" },
      d = { name = "+Dap" },
      g = { name = "+Git" },
      l = { name = "+Lsp" },
      n = { name = "+NvChad" },
      p = { name = "+Preview" },
      r = { name = "+Rename" },
      s = { name = "+Search" },
      w = { name = "+Whichkey" },
    },
  }
end
