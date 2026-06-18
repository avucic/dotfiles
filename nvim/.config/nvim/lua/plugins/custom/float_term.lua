local M = {}

local defaults = { cmd = nil, width = 0.9, height = 0.9, border = 'rounded', title = nil }
local instances = {}

local function create_float(opts)
  local width  = math.floor(vim.o.columns * opts.width)
  local height = math.floor(vim.o.lines * opts.height)
  local buf = vim.api.nvim_create_buf(false, true)
  local cfg = {
    relative = 'editor',
    width    = width,
    height   = height,
    row      = math.floor((vim.o.lines - height) / 2),
    col      = math.floor((vim.o.columns - width) / 2),
    style    = 'minimal',
    border   = opts.border,
  }
  if opts.title then
    cfg.title     = ' ' .. opts.title .. ' '
    cfg.title_pos = 'center'
  end
  return buf, vim.api.nvim_open_win(buf, true, cfg)
end

function M.open(opts)
  opts = vim.tbl_deep_extend('force', defaults, opts or {})
  if not opts.cmd then
    vim.notify("[float_term] 'cmd' is required", vim.log.levels.ERROR)
    return
  end

  local key  = opts.cmd
  local inst = instances[key]

  if inst and vim.api.nvim_win_is_valid(inst.win) then
    vim.api.nvim_win_close(inst.win, true)
    instances[key] = nil
    return
  end

  local buf, win = create_float(opts)
  instances[key] = { buf = buf, win = win }

  local function cleanup()
    if vim.api.nvim_win_is_valid(win)  then vim.api.nvim_win_close(win, true) end
    if vim.api.nvim_buf_is_valid(buf)  then vim.api.nvim_buf_delete(buf, { force = true }) end
    instances[key] = nil
  end

  vim.fn.jobstart(opts.cmd, {
    term    = true,
    on_exit = function() vim.schedule(cleanup) end,
  })
  vim.cmd('startinsert')

  vim.keymap.set('t', '<C-q>', cleanup, { buffer = buf, desc = 'Close float terminal' })
  vim.keymap.set('n', 'q',     cleanup, { buffer = buf, desc = 'Close float terminal' })
end

function M.setup(opts)
  defaults = vim.tbl_deep_extend('force', defaults, opts or {})
end

return M
