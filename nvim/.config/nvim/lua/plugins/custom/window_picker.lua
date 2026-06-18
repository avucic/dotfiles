local M = {}
local api = vim.api
local fn  = vim.fn

local escape     = 27
local float_h    = 3
local float_w    = 6
local config = {
  chars     = vim.split('abcdefghijklmnopqrstuvwxyz', ''),
  normal_hl = '@constant',
  hint_hl   = 'Bold',
  border    = 'single',
}

local function window_keys(windows)
  local mapping = {}
  local nrs, ids = {}, {}
  local current = api.nvim_win_get_number(api.nvim_get_current_win())

  for _, win in ipairs(windows) do
    local nr = api.nvim_win_get_number(win)
    table.insert(nrs, nr)
    ids[nr] = win
  end
  table.sort(nrs)

  local index = 1
  for _, nr in ipairs(nrs) do
    if nr ~= current then
      local key = config.chars[index]
      if mapping[key] then key = key .. (index == #config.chars and config.chars[1] or config.chars[index + 1]) end
      mapping[key] = ids[nr]
    end
    index = index == #config.chars and 1 or index + 1
  end
  return mapping
end

local function open_floats(mapping)
  local floats = {}
  for key, window in pairs(mapping) do
    local bufnr = api.nvim_create_buf(false, true)
    if bufnr > 0 then
      local ww = api.nvim_win_get_width(window)
      local wh = api.nvim_win_get_height(window)
      api.nvim_buf_set_lines(bufnr, 0, -1, true, { '', '  ' .. key .. '  ', '' })
      api.nvim_buf_add_highlight(bufnr, 0, config.hint_hl, 1, 0, -1)
      local fw = api.nvim_open_win(bufnr, false, {
        relative  = 'win',
        win       = window,
        row       = math.max(0, math.floor((wh / 2) - 1)),
        col       = math.max(0, math.floor((ww / 2) - float_w)),
        width     = #key == 1 and float_w - 1 or float_w,
        height    = float_h,
        focusable = false,
        style     = 'minimal',
        border    = config.border,
        noautocmd = true,
        zindex    = 999,
      })
      api.nvim_set_option_value('winhl', 'Normal:' .. config.normal_hl, { win = fw })
      api.nvim_set_option_value('diff',  false, { win = fw })
      floats[fw] = bufnr
    end
  end
  vim.cmd('redraw')
  return floats
end

local function close_floats(floats)
  for win, bufnr in pairs(floats) do
    api.nvim_win_close(win, true)
    api.nvim_buf_delete(bufnr, { force = true })
  end
end

local function get_char()
  local ok, char = pcall(fn.getchar)
  return ok and fn.nr2char(char) or nil
end

function M.setup(user_config)
  config = vim.tbl_extend('force', config, user_config or {})
end

function M.pick(opts)
  opts = opts or {}
  local delete  = opts.delete or false
  local windows = vim.tbl_filter(
    function(id) return api.nvim_win_get_config(id).relative == '' end,
    api.nvim_tabpage_list_wins(0)
  )

  local keys   = window_keys(windows)
  local floats = open_floats(keys)
  local key    = get_char()

  if not key or key == fn.nr2char(escape) then
    close_floats(floats)
    return
  end

  local window  = keys[key]
  local extra   = {}
  local choices = 0
  for hint, win in pairs(keys) do
    if vim.startswith(hint, key) then extra[hint] = win; choices = choices + 1 end
  end

  if choices > 1 then
    close_floats(floats)
    floats = open_floats(extra)
    local second = get_char()
    if second then window = keys[key .. second] or keys[key] else window = nil end
  end

  close_floats(floats)
  if window then
    if delete then api.nvim_win_hide(window) else api.nvim_set_current_win(window) end
  end
  return window
end

return M
