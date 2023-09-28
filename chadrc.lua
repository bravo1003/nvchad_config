---@diagnostic disable: missing-fields, assign-type-mismatch
---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  hl_add = highlights.add,
  hl_override = highlights.override,
  changed_themes = {
    catppuccin = {
      base_30 = {
        lavender = "#b4befe",
      },
    },
  },
  theme_toggle = { "catppuccin", "rosepine" },
  theme = "catppuccin", -- default theme
  transparency = false,
  lsp_semantic_tokens = true, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens

  extended_integrations = {
    "dap",
    "navic",
    "notify",
    "rainbowdelimiters",
    "hop",
    "todo",
    "trouble",
    "codeactionmenu",
  },

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default",
    border_color = "grey_fg",
    selected_item_bg = "colored",
  },

  statusline = {
    theme = "default",
    separator_style = "default",
    overriden_modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    show_numbers = false,
    enabled = true,
    lazyload = true,
    overriden_modules = function(modules)
      table.remove(modules, 1)
      modules[1] = require("custom.utils.tabuflineutils").bufferlist()
    end,
  },

  nvdash = {
    load_on_startup = true,

    header = {
      "           ▄ ▄                   ",
      "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
      "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
      "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
      "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    },

    buttons = {
      { "  Find File", "Spc s f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc s o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc s g", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc n t", "Telescope themes" },
      { "  Mappings", "Spc n c", "NvCheatsheet" },
    },
  },

  cheatsheet = { theme = "grid" }, -- simple/grid

  lsp = {
    signature = {
      disabled = false,
      silent = true,
    },
  },
}
M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
