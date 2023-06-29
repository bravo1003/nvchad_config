require("formatter").setup {
  -- Enable or disable logging
  logging = false,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    c = {
      require("formatter.filetypes.c").clangformat,
    },
    cpp = {
      require("formatter.filetypes.cpp").clangformat,
    },
    rust = {
      require("formatter.filetypes.rust").rustfmt,
    },
    go = {
      require("formatter.filetypes.go").gofmt,
    },
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
    javascript = {
      require("formatter.filetypes.javascript").denofmt,
    },
    typescript = {
      require("formatter.filetypes.typescript").denofmt,
    },
    yaml = {
      require("formatter.filetypes.yaml").prettier,
    },
    html = {
      require("formatter.filetypes.html").prettier,
    },
    markdown = {
      require("formatter.filetypes.markdown").prettier,
    },
    css = {
      require("formatter.filetypes.css").prettier,
    },
    sh = {
      require("formatter.filetypes.sh").shfmt,
    },
    toml = {
      require("formatter.filetypes.toml").taplo,
    },
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
}
