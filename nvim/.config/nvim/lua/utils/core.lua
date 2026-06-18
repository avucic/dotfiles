local M = {}

local function center_text(text, total_width)
  local len = #text
  if len >= total_width then return text end
  local padding = total_width - len
  local left = math.floor(padding / 2)
  return string.rep(' ', left) .. text .. string.rep(' ', padding - left)
end

function M.get_visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})
  text = string.gsub(text, '\n', '')
  return #text > 0 and text or ''
end

function M.show_popup_with_descriptions(descriptions_list, title)
  title = title or 'Info'
  local buf = vim.api.nvim_create_buf(false, true)

  local header_lines = 2
  local desired_height = header_lines + #descriptions_list
  local win_height = math.floor(math.min(desired_height, vim.o.lines * 0.8))

  local max_len = #title
  for _, line in ipairs(descriptions_list) do
    max_len = math.max(max_len, #line)
  end
  local win_width = math.max(40, max_len + 4)

  local win = vim.api.nvim_open_win(buf, true, {
    relative  = 'editor',
    row       = math.floor((vim.o.lines - win_height) / 2),
    col       = math.floor((vim.o.columns - win_width) / 2),
    width     = win_width,
    height    = win_height,
    border    = 'single',
    style     = 'minimal',
    focusable = true,
  })

  local content_width = win_width - 4
  local lines = { center_text(title, content_width), '' }
  for _, line in ipairs(descriptions_list) do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_option_value('buflisted',  false, { buf = buf })
  vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
  vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })
  return win
end

function M.define_keymap_and_get_description(mode, key, rhs, desc, bufnr)
  vim.keymap.set(mode, key, rhs, { desc = desc, buffer = bufnr })
  return string.format('  %-10s : %s', key, desc)
end

function M.setup_keymaps_and_help_popup(bufnr, keymap_configs, help_title)
  local descriptions = {}
  help_title = help_title or '--- Keymaps ---'
  for _, cfg in ipairs(keymap_configs) do
    table.insert(
      descriptions,
      M.define_keymap_and_get_description(cfg.mode or 'n', cfg.key, cfg.rhs, cfg.desc, bufnr)
    )
  end
  vim.keymap.set('n', 'g?', function()
    M.show_popup_with_descriptions(descriptions, help_title)
  end, { desc = 'Show buffer keymaps', buffer = bufnr })
end

function M.open_scratch_float()
  local file = os.getenv('SCRATCHPAD_FILE') or vim.fn.expand('~/Dropbox/Notes/scratchpad.md')
  if vim.fn.filereadable(file) == 0 then vim.fn.writefile({}, file) end

  local buf = vim.fn.bufnr(file, true)
  vim.fn.bufload(buf)
  vim.bo[buf].bufhidden = 'hide'

  local width  = math.floor(vim.o.columns * 0.75)
  local height = math.floor(vim.o.lines * 0.75)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width    = width,
    height   = height,
    row      = math.floor((vim.o.lines - height) / 2),
    col      = math.floor((vim.o.columns - width) / 2),
    border   = 'rounded',
  })

  vim.api.nvim_set_option_value('wrap',         true,  { win = win })
  vim.api.nvim_set_option_value('linebreak',    true,  { win = win })
  vim.api.nvim_set_option_value('spell',        true,  { win = win })
  vim.api.nvim_set_option_value('conceallevel', 2,     { win = win })
  vim.api.nvim_set_option_value('concealcursor','nc',  { win = win })

  vim.keymap.set('n', 'q', function()
    if vim.bo[buf].modified then vim.cmd('silent! write') end
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
  end, { buffer = buf, silent = true, nowait = true })
end

return M
