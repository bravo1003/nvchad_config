---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["gi"] = "",
    ["<A-i>"] = "",
    ["<A-v>"] = "",
    ["<A-h>"] = "",

    -- find
    ["<leader>D"] = "",
    ["<leader>n"] = "",
    ["<leader>v"] = "",
    ["<leader>ff"] = "",
    ["<leader>fa"] = "",
    ["<leader>fw"] = "",
    ["<leader>fb"] = "",
    ["<leader>fh"] = "",
    ["<leader>fo"] = "",
    ["<leader>fz"] = "",
    ["<leader>fm"] = "",
    ["<leader>ca"] = "",
    ["<leader>cm"] = "",
    ["<leader>ra"] = "",
    ["<leader>rh"] = "",
    ["<leader>ma"] = "",
    ["<leader>td"] = "",
    ["<leader>ph"] = "",
    ["<leader>pt"] = "",
    ["<leader>th"] = "",
    ["<leader>ch"] = "",
    ["<leader>lf"] = "",

    -- nvim tree default
    ["<C-n>"] = "",
    ["<C-c>"] = "",
    ["<C-s>"] = "",
  },
  i = {
    ["<C-b>"] = "",
  },
  t = {
    ["<A-i>"] = "",
    ["<A-v>"] = "",
    ["<A-h>"] = "",
  },
}

M.general = {
  i = {
    ["<C-a>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },
  },
  o = {
    -- TreeHopper in operator pending mode
    ["<leader>t"] = {
      "<cmd> lua require('tsht').nodes() <cr>",
      "TreeHopper Visual Selection",
    },
  },
  n = {
    -- General control map
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    -- Resize with arrows
    ["<C-Up>"] = {"<cmd> resize -2 <CR>"},
    ["<C-Down>"] = {"<cmd> resize +2 <CR>"},
    ["<C-Left>"] = {"<cmd> vertical resize -2 <CR>"},
    ["<C-Right>"] = {"<cmd> vertical resize +2 <CR>"},
    -- Search terms stay in middle
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },
    ["Q"] = { "<nop>" },

    -- void delete
    ["x"] = {
      [["_x]],
      "Delete void register",
    },

    ["<leader>q"] = { "<cmd> TroubleToggle document_diagnostics <CR>", "Trouble Toggle" },
    ["<leader>nc"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
    ["<leader>h"] = { "<cmd> HopWord <cr>", "Hop word" },
    ["<leader>t"] = {
      function()
        require("tsht").nodes()
      end,
      "TreeHopper nodes",
    },

    -- Treesitter context
    ["<leader>cc"] = {
      function()
        require("treesitter-context").go_to_context()
      end,
      "Go to context",
    },
    -- Git realted mapping
    ["<leader>gb"] = { "<cmd> Git blame <cr>", "Git blame" },
    ["<leader>gf"] = { "<cmd> Git reformat <cr>", "Git reformat (Xperi Only)" },
    ["<leader>gg"] = {
      function()
        require("custom.utils.lazygit").lazygit_toggle()
      end,
      "Toggle lazygit",
    },
    ["gl"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },
    ["<leader>gj"] = {
      function()
        package.loaded.gitsigns.next_hunk()
      end,
      "Next Hunk",
    },
    ["<leader>gk"] = {
      function()
        package.loaded.gitsigns.prev_hunk()
      end,
      "Previous Hunk",
    },
    ["<leader>gR"] = {
      function()
        package.loaded.gitsigns.reset_hunk()
      end,
      "Reset Hunk",
    },
    ["<leader>gB"] = {
      function()
        package.loaded.gitsigns.reset_buffer()
      end,
      "Reset Buffer",
    },
    ["<leader>gS"] = {
      function()
        package.loaded.gitsigns.stage_hunk()
      end,
      "Stage Hunk",
    },
    ["<leader>gU"] = {
      function()
        package.loaded.gitsigns.undo_stage_hunk()
      end,
      "Undo Stage Hunk",
    },

    -- Got to preview
    ["<leader>pd"] = {
      function()
        require("goto-preview").goto_preview_definition()
      end,
      "Preview definition",
    },
    ["<leader>pt"] = {
      function()
        require("goto-preview").goto_preview_type_definition()
      end,
      "Preview type definition",
    },
    ["<leader>pi"] = {
      function()
        require("goto-preview").goto_preview_implementation()
      end,
      "Preview implementation",
    },
    ["<leader>pr"] = {
      function()
        require("goto-preview").goto_preview_references()
      end,
      "Preview reference",
    },
    ["<leader>pc"] = {
      function()
        require("goto-preview").close_all_win()
      end,
      "Close all previews",
    },

    -- LSP related map
    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
    ["<leader>lf"] = {
      -- function()
      --   vim.lsp.buf.format { async = true }
      -- end,
      "<cmd> Format <cr>",
      "Formatting",
    },
    ["<leader>la"] = {
      --[[ function()
        vim.lsp.buf.code_action()
      end, ]]
      "<cmd> CodeActionMenu <cr>",
      "LSP code action",
    },
    ["<leader>lr"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>u"] = { "<cmd> UndotreeToggle <cr> <cmd> vertical resize 30 <cr>", "Undo Tree history" },
    ["<leader>rn"] = { [[:%s/\<lt><C-R><C-W>\>/<C-R><C-W>/gI<Left><Left><Left>]], "Rename String" },
    ["<C-s>"] = { "<cmd> Navbuddy <cr>", "Navbuddy symbol table toggle" },
    -- ["<A-s>"] = { "<cmd> SymbolsOutline <cr>", "SymbolOutline table toggle" },

    -- harpoon
    ["<C-e>"] = {
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      "Harpoon toggle",
    },
    ["<C-a>"] = {
      function()
        require("harpoon.mark").add_file()
      end,
      "Haarpoon add files",
    },

    -- Dap
    ["<F1>"] = {
      function()
        require("dap").step_over()
      end,
      "Step over",
    },
    ["<F2>"] = {
      function()
        require("dap").step_into()
      end,
      "Step into",
    },
    ["<F3>"] = {
      function()
        require("dap").step_out()
      end,
      "Step out",
    },
    ["<F5>"] = {
      function()
        require("dap").continue()
        require("dapui").open()
      end,
      "Start or continue debugger",
    },
    ["<leader>db"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Add breakpoint",
    },
    ["<leader>dB"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input "Condition: ")
      end,
      "Add conditional breakpoint",
    },
    ["<leader>dr"] = {
      function()
        require("dap").continue()
        require("dapui").open()
      end,
      "Start or continue debugger",
    },
    ["<leader>dt"] = {
      function()
        require("dapui").close()
        require("dap").terminate()
      end,
      "Terminate debugger",
    },
  },
  v = {
    ["<leader>y"] = {
      function()
        require("osc52").copy_visual()
      end,
      "Osc52 remote yank",
    },
    -- Visual mode move text
    ["<A-j>"] = { ":m '>+1<CR>gv=gv" },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv" },
    -- Void paste
    ["<leader>d"] = { [["_d]], "Delete void register" },
    ["x"] = { [["_x]], "Delete void register" },

    ["<leader>la"] = {
      --[[ function()
        vim.lsp.buf.code_action()
      end, ]]
      "<cmd> CodeActionMenu <cr>",
      "LSP code action",
    },
  },
  x = {
    ["p"] = { [["_dP]] },
  },
}

M.telescope = {
  n = {
    -- Search related map
    ["<leader>sb"] = { "<cmd> Telescope buffers theme=ivy <cr>", "Search buffer" },
    ["<leader>sw"] = { "<cmd> Telescope grep_string theme=ivy <cr>", "Search current word" },
    ["<leader>sg"] = { "<cmd> Telescope live_grep theme=ivy <cr>", "Search by grep" },
    ["<leader>sG"] = { "<cmd> Telescope git_files theme=ivy <cr>", "Search git files" },
    ["<leader>s/"] = { "<cmd> Telescope current_buffer_fuzzy_find theme=ivy <cr>", "Search current buffer string" },
    ["<leader>sf"] = { "<cmd> Telescope find_files theme=ivy <cr>", "Search all files" },
    ["<leader>so"] = { "<cmd> Telescope oldfiles theme=ivy <cr>", "Search recent files" },
    ["<A-i>"] = { "<cmd> Telescope luasnip theme=ivy<cr>", "Telescope snippets" },

    ["<leader>nt"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
  },
}

M.lspconfig = {
  n = {
    ["gr"] = { "<cmd> Telescope lsp_references theme=ivy <cr>", "Go to references" },
    ["gd"] = { "<cmd> Telescope lsp_definitions theme=ivy <cr>", "Go to definition" },
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "Go to declaration",
    },
    ["gI"] = { "<cmd> Telescope lsp_implementations theme=ivy <cr>", "Go to implementation" },
  },
}

M.tabufline = {
  n = {
    -- cycle through buffers
    ["<A-h>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    ["<A-l>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },
  },
}

M.focus = {
  n = {
    ["<C-w>s"] = { "<cmd> FocusSplitDown <cr>", "Horizontal Split" },
    ["<C-w>v"] = { "<cmd> FocusSplitRight <cr>", "Vertical Split" },
  },
}

return M
