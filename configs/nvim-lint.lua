local nvim_lint = require "lint"
local cpplint = require("lint").linters.cpplint
local luacheck = require("lint").linters.luacheck

cpplint.args = {
  "--filter=-legal",
}
luacheck.args = {
  "--formatter",
  "plain",
  "--codes",
  "--ranges",
  "--globals vim",
  -- "--filename",
  -- "$FILENAME",
  "-",
}

nvim_lint.linters_by_ft = {
  cpp = { "cpplint" },
  c = { "cpplint" },
  go = { "golangcilint" },
  lua = { "luacheck" },
  yaml = { "yamllint" },
  markdown = { "markdownlint" },
}

vim.api.nvim_create_autocmd({
  "BufWinEnter",
  "InsertLeave",
  "TextChanged",
  "BufWritePost",
}, {
  callback = function()
    nvim_lint.try_lint()
  end,
})
