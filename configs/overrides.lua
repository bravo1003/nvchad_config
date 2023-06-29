local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "bash",
    "c",
    "cpp",
    "rust",
    "go",
    "dockerfile",
    "devicetree",
    "markdown",
    "regex",
    "python",
    "markdown_inline",
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<TAB>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
    },
    is_supported = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == "c" then
        return false
      end
      return true
    end,
  },
  -- textsubjects = {
  --   enable = true,
  --   prev_selection = "<S-tab>",
  --   keymaps = {
  --     ["<cr>"] = "textsubjects-smart",
  --     [";"] = "textsubjects-container-outer",
  --     ["i;"] = "textsubjects-container-inner",
  --   },
  -- },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>ca"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>cA"] = "@parameter.inner",
      },
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "yaml-language-server",
    "yamllint",

    -- c/cpp stuff
    "clangd",
    "clang-format",
    "cpplint",
    "codelldb",

    -- rust
    "rust-analyzer",

    -- go
    "delve",
    "gopls",
    "golangci-lint",

    -- markdown
    "markdownlint",

    "luacheck",
  },
}

M.telescope = {
  defaults = {
    layout_config = {
      bottom_pane = {
        preview_cutoff = 1,
      },
      horizontal = {
        preview_cutoff = 1,
      },
    },
    winblend = 8,
    selection_caret = " ",
    path_display = { "smart" },
  },

  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type",
        "file",
        "--type",
        "symlink",
        "--hidden",
        "--no-ignore",
        -- ".git",
      },
    },
  },

  extensions_list = { "themes", "terms", "fzf", "luasnip" },
}

M.noice = {
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
    },
  },
  routes = {
    {
      filter = { event = "msg_show", kind = "", find = "written" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "nvim_win_close" },
      opts = { skip = true },
    },
    {
      view = "split",
      filter = { event = "msg_show", min_height = 20 },
    },
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
  },
  lsp = {
    hover = {
      enabled = false,
    },
    signature = {
      enabled = false,
    },
    override = {
      -- override the default lsp markdown formatter with Noice
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      -- override the lsp markdown formatter with Noice
      ["vim.lsp.util.stylize_markdown"] = true,
      -- override cmp documentation with Noice (needs the other options to work)
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    long_message_to_split = true, -- long messages will be sent to a split
  },
}

M.indentblankline = {
  indentLine_enabled = 1,
  filetype_exclude = {
    "help",
    "terminal",
    "lazy",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "mason",
    "nvdash",
    "nvcheatsheet",
    "noice",
    "NvimTree",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = false,
  use_treesitter = true,
}

M.which_key = {
  plugins = {
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
}

-- git support in nvimtree
M.nvimtree = {
  disable_netrw = true,
  hijack_netrw = true,
  prefer_startup_root = true,
  hijack_cursor = true,
  view = {
    relativenumber = true,
  },

  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    indent_width = 2,
    icons = {
      show = {
        git = true,
      },
    },
  },

  update_focused_file = {
    update_root = true,
  },
}

local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 70
local MIN_LABEL_WIDTH = 35
local cmp = require "cmp"
M.cmp = {
  completion = {
    keyword_length = 1,
  },
  formatting = {
    format = function(_, item)
      local cmp_ui = require("core.utils").load_config().ui.cmp
      local icons = require "nvchad.icons.lspkind"
      local icon = (cmp_ui.icons and icons[item.kind]) or ""

      local label = item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
      if truncated_label ~= label then
        item.abbr = truncated_label .. ELLIPSIS_CHAR
      elseif string.len(label) < MIN_LABEL_WIDTH then
        local padding = string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
        item.abbr = label .. padding
      end
      icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
      item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")

      return item
    end,
  },
  mapping = {
    ["<UP>"] = cmp.mapping.select_prev_item(),
    ["<DOWN>"] = cmp.mapping.select_next_item(),
  },
  sources = {
    { name = "nvim_lsp", priority = 60 },
    { name = "luasnip", priority = 50 },
    { name = "nvim_lua", priority = 40 },
    { name = "cmp_tabnine", priority = 30 },
    { name = "buffer", priority = 20 },
    { name = "path", priority = 10 },
  },
}

return M
