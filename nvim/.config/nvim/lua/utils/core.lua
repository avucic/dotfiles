local M = {}

local center_text = function(text, total_width)
  local text_len = #text
  if text_len >= total_width then
    return text -- Text is too long or fits exactly, no centering needed
  end
  local padding = total_width - text_len
  local left_padding = math.floor(padding / 2)
  local right_padding = padding - left_padding
  return string.rep(" ", left_padding) .. text .. string.rep(" ", right_padding)
end

function M.get_visual_selection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg "v"
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

function M.show_popup_with_descriptions(descriptions_list, title)
  title = title or "Info"

  local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer

  -- Calculate dynamic height
  local header_lines = 2 -- For title and the empty line
  local content_lines = #descriptions_list
  local desired_height = header_lines + content_lines

  -- Max height should be a percentage of the editor height, e.g., 80%
  local max_editor_height = vim.o.lines * 0.8
  local win_height = math.floor(math.min(desired_height, max_editor_height))

  -- Calculate width dynamically based on the longest line + some padding
  local win_width = 40 -- Minimum width
  local max_line_len = #title
  for _, line in ipairs(descriptions_list) do
    max_line_len = math.max(max_line_len, #line)
  end
  win_width = math.max(win_width, max_line_len + 4) -- Add padding for border and spacing

  local row = (vim.o.lines - win_height) / 2
  local col = (vim.o.columns - win_width) / 2

  local win_id = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = math.floor(row),
    col = math.floor(col),
    width = win_width,
    height = win_height,
    border = "single", -- or "rounded", "double", etc.
    style = "minimal",
    focusable = true,
  })

  -- Populate the buffer with information
  local content_width_for_centering = win_width - 4 -- Adjust for border and internal spacing
  local centered_title = center_text(title, content_width_for_centering)
  local popup_lines = { centered_title, "" }
  for _, line in ipairs(descriptions_list) do
    table.insert(popup_lines, line)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, popup_lines)

  -- Set options for the popup buffer
  vim.api.nvim_set_option_value("buflisted", false, { buf = buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  -- Close the popup when pressing <Esc>
  -- vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>close<CR>", { silent = true })
  vim.keymap.set("n", "<ESC>", "<cmd>close<cr>", { desc = "Close", buffer = buf, silent = true })

  return win_id
end

--- Defines a Neovim keymap and returns its formatted description.
--- @param mode string The mode for the keymap (e.g., "n", "v", "i").
--- @param key string The key sequence.
--- @param rhs string|function The right-hand side of the mapping.
--- @param desc string The description of the keymap.
--- @param bufnr number The buffer number to apply the keymap to.
--- @return string A formatted string representing the keymap and its description.
function M.define_keymap_and_get_description(mode, key, rhs, desc, bufnr)
  vim.keymap.set(mode, key, rhs, { desc = desc, buffer = bufnr })
  return string.format("  %-10s : %s", key, desc)
end

--- Sets up multiple keymaps for a given buffer and registers a help popup
--- triggered by 'g?' that displays these keymaps.
--- @param bufnr number The buffer number to apply keymaps to.
--- @param keymap_configs table A list of tables, each with { mode, key, rhs, desc }.
--- @param help_title string|nil The title for the help popup. Defaults to "--- Keymaps ---".
function M.setup_keymaps_and_help_popup(bufnr, keymap_configs, help_title)
  local keymap_descriptions = {}
  help_title = help_title or "--- Keymaps ---"

  for _, config in ipairs(keymap_configs) do
    local mode = config.mode or "n" -- Default to normal mode if not specified
    table.insert(
      keymap_descriptions,
      M.define_keymap_and_get_description(mode, config.key, config.rhs, config.desc, bufnr)
    )
  end

  -- Set up the 'g?' keymap to show the popup
  vim.keymap.set(
    "n",
    "g?",
    function() M.show_popup_with_descriptions(keymap_descriptions, help_title) end,
    { desc = "Show buffer keymaps", buffer = bufnr }
  )
end

function M.open_scratch_float()
  local file = vim.fn.expand "~/Dropbox/Notes/scratchpad.md"

  -- Ensure file exists
  if vim.fn.filereadable(file) == 0 then vim.fn.writefile({}, file) end

  -- Create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- 🔑 give buffer a name so :w works
  vim.api.nvim_buf_set_name(buf, "scratch://notes")

  vim.bo[buf].buftype = "acwrite"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true
  vim.bo[buf].filetype = "markdown"

  -- Load file contents
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(file))
  vim.b[buf].scratch_target_file = file

  -- Intercept :w
  vim.api.nvim_create_autocmd("BufWriteCmd", {
    buffer = buf,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      vim.fn.writefile(lines, file)
      vim.bo[buf].modified = false
      vim.notify("Scratch saved ✔", vim.log.levels.INFO)
    end,
  })

  -- Floating window
  local width = math.floor(vim.o.columns * 0.75)
  local height = math.floor(vim.o.lines * 0.75)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })

  -- Writing-friendly
  vim.wo.wrap = true
  vim.wo.spell = true
  vim.wo.linebreak = true

  vim.keymap.set("n", "q", function()
    local win = vim.fn.bufwinid(buf)
    if win ~= -1 then vim.api.nvim_win_close(win, true) end
  end, {
    buffer = buf, -- 🔑 THIS is what scopes it
    silent = true,
    nowait = true,
  })
end

return M
