local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- webdev stuff
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  -- b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "yaml" } },
  -- Lua
  -- b.formatting.stylua,
  --
  -- -- cpp
  -- b.formatting.clang_format,
  b.diagnostics.cpplint.with { args = { "--filter=-legal", "$FILENAME" } },
  b.diagnostics.golangci_lint,
  b.diagnostics.luacheck.with {
    args = { "--formatter", "plain", "--codes", "--ranges", "--globals vim", "--filename", "$FILENAME", "-" },
  },
  b.diagnostics.markdownlint,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
