local g = vim.g
local base16 = require("base46").get_theme_tb "base_16"
local colors = require("base46").get_theme_tb "base_30"

require("toggleterm").setup {
  direction = "float",
  open_mapping = "<C-\\>",
  terminal_mappings = true,
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  on_close = function(_) end,
}

-- Catppuccin colorscheme
-- g.terminal_color_0 = "#6c7086"
-- g.terminal_color_8 = "#7f849c"
g.terminal_color_0 = base16.base04
g.terminal_color_8 = colors.grey
g.terminal_color_1 = colors.red
g.terminal_color_9 = colors.red
g.terminal_color_2 = colors.green
g.terminal_color_10 = colors.green
g.terminal_color_3 = colors.yellow
g.terminal_color_11 = colors.yellow
g.terminal_color_4 = colors.blue
g.terminal_color_12 = colors.blue
g.terminal_color_5 = colors.pink
g.terminal_color_13 = colors.pink
g.terminal_color_6 = colors.teal
g.terminal_color_14 = colors.teal
g.terminal_color_7 = colors.lavender
g.terminal_color_15 = colors.lavender
