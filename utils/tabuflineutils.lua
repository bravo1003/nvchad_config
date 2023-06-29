local devicons_present, devicons = pcall(require, "nvim-web-devicons")
--
---------------------------------------------------------- btn onclick functions ----------------------------------------------

vim.cmd "function! TbGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction"
vim.cmd [[
   function! TbKillBuf(bufnr,b,c,d)
        call luaeval('require("nvchad.tabufline").close_buffer(_A)', a:bufnr)
  endfunction]]

-------------------------------------------------------- functions ------------------------------------------------------------
--
local isBufValid = function(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

local function new_hl(group1, group2)
  local fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group1)), "fg#")
  local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group2)), "bg#")
  vim.api.nvim_set_hl(0, "Tbline" .. group1 .. group2, { fg = fg, bg = bg })
  return "%#" .. "Tbline" .. group1 .. group2 .. "#"
end

local function getBtnsWidth() -- close, theme toggle btn etc
  local width = 6
  if vim.fn.tabpagenr "$" ~= 1 then
    width = width + ((3 * vim.fn.tabpagenr "$") + 2) + 10
    width = not vim.g.TbTabsToggled and 8 or width
  end
  return width
end

local function add_fileInfo(name, bufnr)
  if devicons_present then
    local icon, icon_hl = devicons.get_icon(name, string.match(name, "%a+$"))

    if not icon then
      icon = "󰈚"
      icon_hl = "DevIconDefault"
    end

    icon = (
      vim.api.nvim_get_current_buf() == bufnr and new_hl(icon_hl, "TbLineBufOn") .. " " .. icon
      or new_hl(icon_hl, "TbLineBufOff") .. " " .. icon
    )

    -- check for same buffer names under different dirs
    for _, value in ipairs(vim.t.bufs) do
      if isBufValid(value) then
        if name == vim.fn.fnamemodify(vim.api.nvim_buf_get_name(value), ":t") and value ~= bufnr then
          local other = {}
          for match in (vim.fs.normalize(vim.api.nvim_buf_get_name(value)) .. "/"):gmatch("(.-)" .. "/") do
            table.insert(other, match)
          end

          local current = {}
          for match in (vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr)) .. "/"):gmatch("(.-)" .. "/") do
            table.insert(current, match)
          end

          name = current[#current]

          for i = #current - 1, 1, -1 do
            local value_current = current[i]
            local other_current = other[i]

            if value_current ~= other_current then
              if (#current - i) < 2 then
                name = value_current .. "/" .. name
              else
                name = value_current .. "/../" .. name
              end
              break
            end
          end
          break
        end
      end
    end

    -- padding around bufname; 24 = bufame length (icon + filename)
    local padding = (22 - #name - 5) / 2
    local maxname_len = 16

    name = (#name > maxname_len and string.sub(name, 1, 14) .. "..") or name
    name = (vim.api.nvim_get_current_buf() == bufnr and "%#TbLineBufOn# " .. name) or ("%#TbLineBufOff# " .. name)

    return string.rep(" ", padding) .. icon .. name .. string.rep(" ", padding)
  end
end

local function styleBufferTab(nr)
  local close_btn = "%" .. nr .. "@TbKillBuf@ 󰅖 %X"
  local name = (#vim.api.nvim_buf_get_name(nr) ~= 0) and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(nr), ":t") or " No Name "
  name = "%" .. nr .. "@TbGoToBuf@" .. add_fileInfo(name, nr) .. "%X"

  -- color close btn for focused / hidden  buffers
  if nr == vim.api.nvim_get_current_buf() then
    close_btn = (vim.bo[0].modified and "%" .. nr .. "@TbKillBuf@%#TbLineBufOnModified#  ")
      or ("%#TbLineBufOnClose#" .. close_btn)
    name = "%#TbLineBufOn#" .. name .. close_btn
  else
    close_btn = (vim.bo[nr].modified and "%" .. nr .. "@TbKillBuf@%#TbLineBufOffModified#  ")
      or ("%#TbLineBufOffClose#" .. close_btn)
    name = "%#TbLineBufOff#" .. name .. close_btn
  end

  return name
end

---------------------------------------------------------- components ------------------------------------------------------------
local M = {}

M.bufferlist = function()
  local buffers = {} -- buffersults
  local available_space = vim.o.columns - getBtnsWidth()
  local current_buf = vim.api.nvim_get_current_buf()
  local has_current = false -- have we seen current buffer yet?

  for _, bufnr in ipairs(vim.t.bufs) do
    if isBufValid(bufnr) then
      if ((#buffers + 1) * 21) > available_space then
        if has_current then
          break
        end

        table.remove(buffers, 1)
      end

      has_current = (bufnr == current_buf and true) or has_current
      table.insert(buffers, styleBufferTab(bufnr))
    end
  end

  vim.g.visibuffers = buffers
  return table.concat(buffers) .. "%#TblineFill#" .. "%=" -- buffers + empty space
end

return M
