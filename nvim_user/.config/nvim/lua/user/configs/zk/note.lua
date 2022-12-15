local M = {}

local actions = require("telescope.actions")
local state = require("telescope.actions.state")
local zk = require("zk")

local create_note_entry_maker = function(_)
  return function(note)
    local icon
    local prefix
    local path = note.absPath
    local title = note.title

    if path:match("daily_notes") then
      prefix = "DN"
      icon = "🗒️"
    elseif path:match("references") then
      prefix = "RN"
      icon = "🔖"
    elseif path:match("literature_notes") then
      prefix = "LN"
      icon = "📚"
    elseif path:match("slip") then
      prefix = "SB"
      icon = "📖"
    elseif path:match("journal/daily") then
      prefix = "DN"
      icon = "📅"
    elseif path:match("projects") then
      prefix = "PN"
      icon = "💼"
    end

    if icon then
      title = prefix .. " " .. icon .. " " .. title
    end

    return {
      value = note,
      path = note.absPath,
      display = title,
      ordinal = title,
    }
  end
end

require("zk.pickers.telescope").create_note_entry_maker = create_note_entry_maker

local titleize = function(s)
  s = s:gsub("%-", " ")
  s = s:gsub("%/", "")
  return s:sub(1, 1):upper() .. s:sub(2)
end

local parse_text = function(text)
  local formatted_text = text:gsub("%.md", ""):gsub("%.", " ")
  return formatted_text
end

local path_display = function(_, path)
  local icon = " "

  if path:match("daily_notes") then
    icon = "🗒️"
  elseif path:match("references") then
    icon = "🔖"
  elseif path:match("literature_notes") then
    icon = "📚"
  elseif path:match("slip") then
    icon = "📖"
  elseif path:match("journal/daily") then
    icon = "📅"
  elseif path:match("projects") then
    icon = "💼"
  end

  if icon then
    return icon .. " " .. path:match("(.+)%..+")
  else
    return path:match("(.+)%..+")
  end
end

function M.open_notebook()
  vim.cmd("e " .. vim.env.ZK_NOTEBOOK_DIR .. "/index.md")
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

  zk.new({ title = title, group = group, dir = pathDir or dir })
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
    path_display = path_display,
    attach_mappings = function(_, map)
      actions.select_default:replace(function()
        return true
      end)

      local run_expand_command = function(prompt_bufnr)
        local num_of_line_prefix_or_whatever = 4 -- first n characters in line before actual text.T TODO

        local selection = state.get_selected_entry()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line = vim.api.nvim_get_current_line()
        local text
        local nline

        if selection ~= nil then
          local note_name = selection.value.title
          nline = line:sub(0, cursor[2] + 1) .. note_name .. line:sub(cursor[2] + 2)
          text = parse_text(note_name)
        else
          local input_text = state.get_current_line()
          text = parse_text(input_text)
        end

        local current_picker = state.get_current_picker(prompt_bufnr)
        current_picker:set_prompt(text)

        return true
      end

      local open_note = function(prompt_bufnr, _)
        local selection = state.get_selected_entry()
        local input_text = state.get_current_line()
        if selection ~= nil then
          M.open_note(selection.value.path, dir, group)
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
  }, opts or {})
  zk.edit({ path = cwd, sort = { "modified" } }, { picker = "telescope", telescope = options })
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
    attach_mappings = function(_, _)
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

function M.open_notes()
  local path = vim.env.ZK_NOTEBOOK_DIR
  local options = {
    sort = { "modified" },
    preview_title = "File preview",
  }
  zk.edit({ path = path, sort = { "modified" } }, { picker = "telescope", telescope = options })
end

function M.find_or_create_note_without_picker(opts)
  assert(opts.title ~= nil, "Missing title")
  assert(opts.dir ~= nil, "Missing dir")
  assert(opts.group ~= nil, "Missing group")

  local _, picker = pcall(require, "window-picker")
  local picked_window_id = picker.pick_window()
  if picked_window_id then
    vim.api.nvim_set_current_win(picked_window_id)
  end

  zk.new({
    title = opts.title,
    group = opts.group,
    dir = opts.dir,
    date = opts.date,
  })
end

function M.annotate_task(opts)
  opts = opts or {}
  local cwd = opts.cwd or vim.env.ZK_NOTEBOOK_DIR
  local options = vim.tbl_deep_extend("force", {
    prompt_title = opts.title or "Notes",
    attach_mappings = function(_, map)
      actions.select_default:replace(function()
        return true
      end)

      local select_note = function(prompt_bufnr, _)
        local selection = state.get_selected_entry()
        -- Created task 4
        -- local command = "task add " .. selection.value.title .. " && " .. "taskopen " .. selection.value.absPath
        local handle = io.popen("task add " .. selection.value.title)
        local result = handle:read("*a")
        handle:close()
        local id = result:gsub("\n", ""):match("%d[%d]*")

        handle = io.popen("task " .. id .. " annotate -- " .. selection.value.absPath)
        result = handle:read("*a")
        handle:close()

        actions.close(prompt_bufnr)
      end

      map("i", "<CR>", select_note)
      map("n", "<CR>", select_note)

      return true
    end,
  }, opts or {})
  require("zk").edit({ path = cwd }, { picker = "telescope", telescope = options })
end

return M
