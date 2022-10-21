local M = {}

M.bool2num = function(bool_or_num)
  if type(bool_or_num) == "boolean" then
    return bool_or_num and 1 or 0
  end
  return bool_or_num
end

--- Useful in vim `:set <option>` style commands
---@param bool boolean Bool to convert to string
---@return string "on" or "off"
M.bool2str = function(bool)
  return bool and "on" or "off"
end


-- Toggle signcolumn="auto"|"no"
M.toggle_signcolumn = function()
  local signcolumn = vim.o.signcolumn
  if signcolumn == "no" then
    vim.opt.signcolumn = "auto"
  else
    vim.opt.signcolumn = "no"
  end
  print(string.format("signcolumn=%s", vim.opt.signcolumn))
end

-- Set the indent and tab related numbers.
-- Negative numbers mean tabstop -- Really though? Tabs?
M.set_indent = function()
  local indent = tonumber(
    vim.fn.input("Set indent (>0 uses spaces, <0 uses tabs, 0 uses vim defaults): ")
  )
  if not indent then
    indent = -8
  end
  vim.opt.expandtab = indent > 0
  indent = math.abs(indent)
  vim.opt.tabstop = indent
  vim.opt.softtabstop = indent
  vim.opt.shiftwidth = indent
  print(string.format("indent=%d %s", indent, vim.opt.expandtab and "spaces" or "tabs"))
end

-- Change the number display modes.
M.change_number = function()
  local number = vim.opt.number
  local relativenumber = vim.opt.relativenumber
  if (number == false) and (relativenumber == false) then
    vim.opt.number = true
    vim.opt.relativenumber = false
  elseif (number == true) and (relativenumber == false) then
    vim.opt.number = false
    vim.opt.relativenumber = true
  elseif (number == false) and (relativenumber == true) then
    vim.opt.number = true
    vim.opt.relativenumber = true
  else -- (number == true) and (relativenumber == true) then
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
  print(
    "number=%s, relativenumber=%s",
    M.bool2str(vim.opt.number),
    M.bool2str(vim.opt.relativenumber)
  )
end

-- Toggle spell.
M.toggle_spell = function()
  vim.opt.spell = not vim.opt.spell
  print(string.format("spell=%s", M.bool2str(vim.opt.spell)))
end

-- Toggle syntax/treesitter
M.change_syntax = function()
  local parsers = require("nvim-treesitter.parsers")
  if parsers.has_parser() then
    if vim.opt.syntax then
      vim.cmd("TSBufDisable highlight")
      vim.cmd("syntax off")
    else
      vim.cmd("TSBufEnable highlight")
      vim.cmd("syntax on")
    end
    local state = M.bool2str(vim.opt.syntax)
    print(string.format("syntax=%s, treesitter=%s", state, state))
  else
    if vim.o.syntax then
      vim.cmd("syntax off")
    else
      vim.cmd("syntax on")
    end
    local state = M.bool2str(vim.opt.syntax)
    print(string.format("syntax=%s", state))
  end
end

return M

