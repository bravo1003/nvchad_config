local dap = require "dap"

-- DAP for C++
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = "codelldb",
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- DAP for C and Rust
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- DAP for Go
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}
