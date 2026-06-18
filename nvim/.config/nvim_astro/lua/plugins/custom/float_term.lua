local M = {}

local defaults = {
  cmd = nil,
  width = 0.9,
  height = 0.9,
  border = "rounded",
  title = nil,
}

-- Keyed by cmd string to support multiple independent instances
local instances = {}

local function create_float(opts)
  local width = math.floor(vim.o.columns * opts.width)
  local height = math.floor(vim.o.lines * opts.height)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)

  local win_cfg = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = opts.border,
  }

  if opts.title then
    win_cfg.title = " " .. opts.title .. " "
    win_cfg.title_pos = "center"
  end

  local win = vim.api.nvim_open_win(buf, true, win_cfg)
  return buf, win
end

--- Open (or toggle closed) a floating terminal running `opts.cmd`.
---@param opts { cmd: string, width?: number, height?: number, border?: string, title?: string }
function M.open(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  if not opts.cmd then
    vim.notify("[float_term] 'cmd' is required", vim.log.levels.ERROR)
    return
  end

  local key = opts.cmd
  local inst = instances[key]

  -- Toggle: close if already open
  if inst and vim.api.nvim_win_is_valid(inst.win) then
    vim.api.nvim_win_close(inst.win, true)
    instances[key] = nil
    return
  end

  local buf, win = create_float(opts)
  instances[key] = { buf = buf, win = win }

  local function cleanup()
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    if vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_buf_delete(buf, { force = true }) end
    instances[key] = nil
  end

  vim.fn.jobstart(opts.cmd, {
    term = true,
    on_exit = function() vim.schedule(cleanup) end,
  })

  vim.cmd "startinsert"

  -- <C-q> force-closes from terminal mode (e.g. when the app has no quit key)
  vim.keymap.set("t", "<C-q>", cleanup, { buffer = buf, desc = "Close float terminal" })
  -- q closes from normal mode (after <C-\><C-n>)
  vim.keymap.set("n", "q", cleanup, { buffer = buf, desc = "Close float terminal" })
end

--- Override global defaults (call from your plugin's config/setup).
---@param opts table
function M.setup(opts) defaults = vim.tbl_deep_extend("force", defaults, opts or {}) end

return M
