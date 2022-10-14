local M = {}

local actions = require("telescope.actions")
local state = require("telescope.actions.state")

local titleize = function(s)
  s = s:gsub("%-", " ")
  s = s:gsub("%/", "")
  return s:sub(1, 1):upper() .. s:sub(2)
end

local parse_text = function(text)
  local formatted_text = text:gsub("%.md", ""):gsub("%.", " ")
  return formatted_text
end

function M.open_notebook()
  M.open_note("index")
end

function M.open_note(path, dir, group)
  assert(path ~= nil and path ~= "", "No text for note path")
  assert(dir ~= nil and dir ~= "", "No text for note dir")
  assert(group ~= nil and group ~= "", "No text for note group")
  local pathDir, filename = path:match("([^,]+)/([^,]+)")

  if filename == nil then
    filename = path
  end

  assert(path ~= nil or dir ~= nil, "No directory for the note")
  assert(group ~= nil or dir ~= nil, "No group for the note")

  local title = titleize(parse_text(filename))

  require("zk").new({ title = title, group = group, dir = dir or pathDir })
end

function M.grep_notes(opts)
  local dir = opts.dir or vim.env.ZK_NOTEBOOK_DIR
  local collection = {}
  local list_opts = { select = { "title", "path", "absPath" } }
  require("zk.api").list(dir, list_opts, function(_, notes)
    for _, note in ipairs(notes) do
      collection[note.absPath] = note.title or note.path
    end
  end)
  local options = vim.tbl_deep_extend("force", {
    prompt_title = "Notes",
    search_dirs = { dir },
    disable_coordinates = true,
    path_display = function(_, path)
      return collection[path]
    end,
  }, {})
  require("telescope.builtin").live_grep(options)
end

function M.find_or_create_note(opts)
  local group = opts.group
  local dir = opts.dir
  local cwd = opts.cwd or vim.env.ZK_NOTEBOOK_DIR
  local options = vim.tbl_deep_extend("force", {
    prompt_title = opts.title or titleize(dir),
    -- default_text = opts.default,
    cwd = cwd,
    find_command = {
      "fd",
      "--exclude",
      "templates",
      "--exclude",
      "journal",
      "--exclude",
      "files",
      "--type",
      "file",
      "--strip-cwd-prefix",
      "-e",
      "md",
    },
    attach_mappings = function(_, map)
      actions.select_default:replace(function()
        return true
      end)

      local run_expand_command = function()
        local num_of_line_prefix_or_whatever = 4 -- first n characters in line before actual text.T TODO

        local selection = state.get_selected_entry()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line = vim.api.nvim_get_current_line()
        local text
        local nline

        if selection ~= nil then
          nline = line:sub(0, cursor[2] + 1) .. selection.value .. line:sub(cursor[2] + 2)
          text = parse_text(selection.value)
        else
          local input_text = state.get_current_line()
          text = parse_text(input_text)
        end

        nline = line:sub(0, cursor[2] - (line:len() - num_of_line_prefix_or_whatever))
          .. text
          .. line:sub(cursor[2] + 2)

        vim.api.nvim_set_current_line(nline)
        vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + text:len() })

        return true
      end

      local open_note = function(prompt_bufnr, _)
        local selection = state.get_selected_entry()
        local input_text = state.get_current_line()
        if selection ~= nil then
          M.open_note(selection.value, dir, group)
          actions.close(prompt_bufnr)
        else
          vim.ui.input({ prompt = "Do you want to create note " .. input_text .. " (y/N) " }, function(input)
            if input ~= nil and input == "y" then
              M.open_note(input_text, dir, group)
            end

            actions.close(prompt_bufnr)
          end)
        end
      end

      local create_note = function(prompt_bufnr, _)
        local input_text = state.get_current_line()
        M.open_note(input_text, dir, group)

        actions.close(prompt_bufnr)
      end

      map("i", "<C-e>", run_expand_command)
      map("i", "<tab>", run_expand_command)
      map("i", "<CR>", open_note)
      map("i", "<C-o>", create_note)
      map("n", "<CR>", open_note)

      return true
    end,

    path_display = function(_, path)
      local icon

      if path:match("^Fleeting Notes/.*") then
        icon = "📓"
      elseif path:match("^Literature Notes/.*") then
        icon = "📙"
      elseif path:match("^Permanent Notes/.*") then
        icon = "📗"
      elseif path:match("^Journal/Daily/.*") then
        icon = "📅"
      end

      if icon then
        return icon .. " " .. path:match("(.+)%..+")
      else
        return path:match("(.+)%..+")
      end
    end,
  }, opts or {})
  require("telescope.builtin").find_files(options)
end

function M.find_or_create_project_note()
  local options = {
    prompt_title = "Projects",
    cwd = "projects",
    find_command = {
      "fd",
      "--type",
      "d",
      "--strip-cwd-prefix",
    },
    attach_mappings = function(_, map)
      actions.select_default:replace(function()
        local selection = state.get_selected_entry()
        local project_dir = vim.env.ZK_NOTEBOOK_DIR .. "/projects/" .. selection.value
        local opts = {
          cwd = project_dir,
          dir = project_dir,
          title = titleize(selection.value),
          group = "project_notes",
        }
        M.find_or_create_note(opts)
        return true
      end)

      return true
    end,
  }
  require("telescope.builtin").find_files(options)
end

function M.find_or_create_note_without_picker(opts)
  assert(opts.title ~= nil, "Missing title")
  assert(opts.dir ~= nil, "Missing dir")
  assert(opts.group ~= nil, "Missing group")

  local _, picker = pcall(require, "window-picker")
  local picked_window_id = picker.pick_window()
  if picked_window_id ~= nil then
    vim.api.nvim_set_current_win(picked_window_id)
  end

  require("zk").new({
    title = opts.title,
    group = opts.group,
    dir = opts.dir,
    date = opts.date,
  })
end

return M
