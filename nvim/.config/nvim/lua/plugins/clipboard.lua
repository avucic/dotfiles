local clipboard_cache = { lines = {}, regtype = "v" }
local function copy(lines, regtype)
  clipboard_cache = { lines = lines, regtype = regtype }

  local s = table.concat(lines, "\n")
  local base64 = vim.fn.system("base64 -w 0", s):gsub("\n", "")

  io.stdout:write(string.format("\x1bPtmux;\x1b\x1b]52;c;%s\x07\x1b\\", base64))
  io.stdout:flush()
end

local function paste() return clipboard_cache.lines, clipboard_cache.regtype end

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local in_docker = file_exists "/.dockerenv"

if in_docker then
  vim.g.clipboard = {
    name = "OSC52-Tmux-Fixed",
    copy = {
      ["+"] = copy,
      ["*"] = copy,
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }

  vim.opt.clipboard = "unnamedplus"
end

return {}
