local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Disabled plugin

  {
    "NvChad/nvterm",
    enabled = false,
  },

  {
    "mfussenegger/nvim-lint",
    enabled = false,
    event = "BufRead",
    config = function()
      require "custom.configs.nvim-lint"
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    enabled = false,
    event = "LspAttach",
    config = function()
      local width = 43
      if vim.loop.os_uname().sysname == "Darwin" then
        width = 30
      end
      require("symbols-outline").setup {
        width = width,
      }
    end,
  },

  -- Enabled plugin
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "mhartington/formatter.nvim",
    cmd = { "Format" },
    config = function()
      require "custom.configs.formatter"
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require "custom.configs.dapconfig"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
        },
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
    config = function()
      dofile(vim.g.base46_cache .. "dap")
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = { "rust" },
    opts = function()
      return require("custom.configs.rust-tools").options
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- "rrethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/nvim-treesitter-context",
        cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
        config = function()
          require("treesitter-context").setup {
            max_lines = 1,
            line_numbers = true,
          }
        end,
      },
    },
    opts = overrides.treesitter,
  },

  {
    "willcassella/nvim-gn",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = "gn",
    config = function()
      require "nvim-gn"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = overrides.indentblankline,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "benfowler/telescope-luasnip.nvim" },
    },
    opts = overrides.telescope,
  },

  {
    "folke/which-key.nvim",
    opts = overrides.which_key,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
      require "custom.configs.whichkey"
    end,
  },

  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      dofile(vim.g.base46_cache .. "navic")
      require("nvim-navic").setup {
        highlight = true,
      }
    end,
  },

  {
    "utilyre/barbecue.nvim",
    event = "LspAttach",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      local base46 = require "custom.utils.base46"
      require("barbecue").setup {
        theme = {
          normal = { fg = base46.base16.base05 },
          separator = { fg = base46.colors.red },
          basename = { fg = base46.base05, bold = false },
        },
        show_dirname = false,
      }
    end,
  },

  {
    "SmiteshP/nvim-navbuddy",
    cmd = { "Navbuddy" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = {
        size = "80%",
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = overrides.noice,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          dofile(vim.g.base46_cache .. "notify")
          require("notify").setup {
            render = "minimal",
            stages = "fade",
          }
        end,
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    init = function()
      require("core.utils").lazy_load "todo-comments.nvim"
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      dofile(vim.g.base46_cache .. "todo")
      require("todo-comments").setup {
        highlight = {
          keyword = "bg",
          pattern = [[.*<(KEYWORDS)\s*(.*):]],
        },
        search = {
          pattern = [[\b(KEYWORDS)\s*(.*):]],
        },
      }
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
    end,
  },

  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeFocus" },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = {
      "ToggleTerm",
      "TermExec",
    },
    keys = { { "<C-\\>", mode = { "n", "t" } } },
    config = function()
      require "custom.configs.toggleterm"
    end,
  },

  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup {
        width = 90, -- Width of the floating window
        height = 20, -- Height of the floating window
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_ivy { winblend = 8, hide_preview = false },
        },
      }
    end,
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    cmd = { "HopWordCurrentLine", "HopWord" },
    config = function()
      dofile(vim.g.base46_cache .. "hop")
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },

  {
    "mfussenegger/nvim-treehopper",
    dependencies = { "phaazon/hop.nvim" },
    config = function()
      require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
    end,
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local width = 80
      if vim.loop.os_uname().sysname == "Darwin" then
        width = 60
      end
      require("harpoon").setup {
        menu = {
          width = width,
        },
      }
    end,
  },

  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure {
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "NvimTree",
          "mason",
          "lazy",
          "toggleterm",
          "harpoon",
          "telescope",
        },
        modes_allowlist = { "n" },
      }
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },

  {
    "npxbr/glow.nvim",
    cmd = "Glow",
    ft = "markdown",
    config = function()
      local bin = os.getenv "HOME" .. "/.local/bin/glow"
      if vim.loop.os_uname().sysname == "Darwin" then
        bin = "/opt/homebrew/bin/glow"
      end
      require("glow").setup {
        glow_path = bin,
        border = "shadow",
        style = "$HOME/.config/glow/mocha.json",
        pager = false,
        width = 120,
        height = 100,
        width_ratio = 0.8,
        height_ratio = 0.8,
      }
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    ft = { "fugitive" },
  },

  {
    "ethanholz/nvim-lastplace",
    event = "BufReadPre",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      }
    end,
  },

  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },

  {
    "mawkler/modicator.nvim",
    init = function()
      require("core.utils").lazy_load "modicator.nvim"
    end,
    config = function()
      -- reletive line number
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.cursorline = true
      require("modicator").setup()
    end,
  },

  {
    "kitagry/vs-snippets",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local vs_snippets = vim.fn.stdpath "data" .. "/lazy/vs-snippets/snippets"
      require("luasnip.loaders.from_vscode").lazy_load { paths = vs_snippets }
    end,
  },

  {
    "madskjeldgaard/cheeky-snippets.nvim",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cheeky = require "cheeky"
      cheeky.setup {
        langs = {
          all = true,
          lua = true,
          cpp = true,
          asm = true,
          cmake = true,
          markdown = true,
          supercollider = true,
        },
      }
    end,
  },

  {
    "ntpeters/vim-better-whitespace",
    event = "BufReadPre",
  },

  {
    "mbledkowski/neuleetcode.vim",
    cmd = {
      "LeetCodeList",
      "LeetCodeTest",
      "LeetCodeSubmit",
      "LeetCodeSignIn",
    },
  },

  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup {
        max_length = 0,
        silent = true,
        trim = true,
      }
    end,
  },

  {
    "nvim-focus/focus.nvim",
    event = "WinEnter",
    ---@diagnostic disable-next-line: assign-type-mismatch
    version = false,
    config = function()
      require("core.utils").load_mappings "focus"
      require("focus").setup {
        ui = {
          hybridnumber = true,
        },
      }
    end,
  },

  {
    "fei6409/log-highlight.nvim",
    ft = "log",
    config = function()
      require("log-highlight").setup {}
    end,
  },

  {
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPre",
    config = function()
      dofile(vim.g.base46_cache .. "rainbowdelimiters")
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    config = function()
      dofile(vim.g.base46_cache .. "codeactionmenu")
    end,
  },

  {
    "rmagatti/gx-extended.nvim",
    keys = { "gx" },
    config = function()
      require("gx-extended").setup {
        extensions = {
          { -- match github repos in lazy.nvim plugin specs
            patterns = { "*/plugins/**/*.lua" },
            name = "neovim plugins",
            match_to_url = function(line_string)
              local line = string.match(line_string, "[\"|'].*/.*[\"|']")
              local repo = vim.split(line, ":")[1]:gsub("[\"|']", "")
              local url = "https://github.com/" .. repo
              return line and repo and url or nil
            end,
          },
        },
        open_fn = require("lazy.util").open,
      }
    end,
  },
}

return plugins
