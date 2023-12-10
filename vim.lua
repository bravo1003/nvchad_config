local g = vim.g
local opt = vim.opt

-- Enable provider
local enable_providers = {
  "python3_provider",
}
for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end
local python3_host_prog = "/usr/bin/python3"
if vim.loop.os_uname().sysname == "Darwin" then
  python3_host_prog = "/opt/homebrew/bin/python3"
end
g.python3_host_prog = python3_host_prog
g.leetcode_browser = "firefox"
g.leetcode_solution_filetype = "cpp"
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

opt.autoread = true
vim.bo.autoread = true
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
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
  end

  if vim.loop.os_uname().sysname == "Darwin" then
    opt.guifont = "JetBrainsMono Nerd Font:h21:w1"
    -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
    -- g.neovide_transparency = 0.0
    -- g.transparency = 0.8
    -- g.neovide_background_color = "#1e1e2e" .. alpha()
    g.neovide_input_macos_alt_is_meta = true
  elseif vim.loop.os_uname().sysname == "Linux" then
    opt.guifont = "JetBrainsMono Nerd Font:h15"
    opt.linespace = -2
  end

  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_vfx_mode = "torpedo"
  g.neovide_scroll_animation_length = 0.2
  -- g.neovide_cursor_vfx_particle_density = 20
  -- g.neovide_cursor_vfx_particle_lifetime = 2
end
