local g = vim.g
local opt = vim.opt

-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Disable clipboard if on ssh session
if vim.api.nvim_call_function("has", { "clipboard" }) ~= 1 then
  opt.clipboard = "unnamedplus"
end

-- no swap files
opt.swapfile = false
opt.backup = false
-- undo hostory directoy
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.undofile = true
-- no line warpping
opt.wrap = false
-- autoread reload changed file
opt.autoread = true
-- -- Set highlight on search
opt.hlsearch = false
opt.incsearch = true
-- Enable break indent
opt.breakindent = true
-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true
-- Decrease update time
opt.updatetime = 250
-- minimun scroll of screen
opt.scrolloff = 8
-- tab set up
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
-- menu and floating window blend
opt.pumblend = 10
opt.winblend = 10
opt.pumheight = 15
opt.colorcolumn = "100"
opt.cmdwinheight = 15

opt.isfname:append "@-@"

g.code_action_menu_window_border = "rounded"

-- Undotree setup
g.undotree_WindowLayout = 1
-- g.undotree_SplitWidth = 30
g.undotree_SetFocusWhenToggle = 1
g.undotree_ShortIndicators = 1
g.undotree_DiffAutoOpen = 0

-- Better white space setup
g.better_whitespace_operator = ""
g.better_whitespace_enabled = 1
g.current_line_whitespace_disabled_hard = 1
g.better_whitespace_filetypes_blacklist = {
  "diff",
  "git",
  "gitcommit",
  "unite",
  "qf",
  "help",
  "markdown",
  "fugitive",
  "lazygit",
  "toggleterm",
  "terminal",
}

--- Setup neovide
if g.neovide then
  opt.guifont = "JetBrainsMono Nerd Font:h15"
  opt.linespace = -2
  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_vfx_mode = "torpedo"
  g.neovide_scroll_animation_length = 0.1
  g.neovide_scroll_animation_length = 0.3
end
