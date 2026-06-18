local M = {}

local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local state = require "telescope.actions.state"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local zk = require "zk"
local util = require "zk.util"

local entry_display = require "telescope.pickers.entry_display"

local split_string = function(s, delimiter)
  delimiter = delimiter or "%s"
  local t = {}
  local i = 1
  for str in string.gmatch(s, "([^" .. delimiter .. "]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

-- local icon_and_prefix = function(path)
--   local icon
--   local prefix
--   local color
--   if path:match "daily_notes" then
--     prefix = "DN"
--     icon = ""
--     color = "DailyNote"
--   elseif path:match "references" then
--     prefix = "RN"
--     icon = ""
--     color = "ReferenceNote"
--   elseif path:match "literature_notes" then
--     prefix = "LN"
--     icon = ""
--     color = "Number"
--   elseif path:match "slip" then
--     prefix = "SB"
--     icon = ""
--     color = "SlipNote"
--   elseif path:match "journal/daily" then
--     prefix = "DN"
--     icon = ""
--     color = "JournalNote"
--   elseif path:match "projects" then
--     prefix = "PN"
--     icon = ""
--     color = "ProjectNote"
--   end
--   return { icon = icon, prefix = prefix, color = color }
-- end

-- https://github.com/nvim-telescope/telescope.nvim/issues/313
local function create_note_entry_maker(opts)
  local displayer = entry_display.create {
    separator = " | ",
    items = {
      -- slighltly increased width
      -- { width = 3 },
      -- { width = 3 },
      -- { width = 48 },
      { remaining = true },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    -- local icnprx = icon_and_prefix(entry.path)
    local title = entry.ordinal

    -- local prefix = string.gmatch(entry.value.path, "([%w-_]+)/")()
    --
    -- if prefix then title = prefix .. ": " .. title end
    -- entry.prefix = prefix

    -- local icon_info = {
    --   table.concat { icnprx.icon },
    --   icnprx.color,
    -- }
    --
    local prefix_info
    local segments = split_string(title, ":")
    local prefix

    if segments[2] then
      title = segments[2]
      prefix = segments[1]
    end

    if prefix then
      prefix_info = {
        table.concat { prefix },
        "ProjectNote",
      }
    else
      prefix_info = prefix
    end

    return displayer {
      -- icon_info,
      prefix_info,
      title,
    }
  end

  return function(entry)
    local title = entry.title
    local ordinal = title

    local prefix = string.gmatch(entry.path, "([%w-_]+)/")()
    if prefix then ordinal = prefix .. ":" .. entry.title end

    return {
      path = entry.absPath,
      display = make_display,
      ordinal = ordinal,
      value = entry,
      -- ordinal = entry.title,
      -- display = make_display,
      --
      -- filename = filename,
      -- type = entry.type,
      -- lnum = entry.lnum,
      -- col = entry.col,
      -- text = entry.title,
      -- start = entry.start,
      -- finish = entry.finish,
    }
  end
end

require("zk.pickers.telescope").create_note_entry_maker = create_note_entry_maker

local titleize = function(s)
  s = s:gsub("%-", " ")
  s = s:gsub("%/", "")
  return s:sub(1, 1):upper() .. s:sub(2)
end
--- Check if a file or directory exists in this path
local exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

local parse_text = function(text)
  local formatted_text = text:gsub("%.md", ""):gsub("%.", " ")
  return formatted_text
end

local get_zk_notebook_dir = function()
  local root = vim.loop.cwd()
  if exists(root .. "/.zk") then
    return root
  else
    return vim.env.ZK_NOTEBOOK_DIR
  end
end

local function get_zk_config_groups()
  local path = get_zk_notebook_dir() .. "/.zk/config.toml"
  local f = io.open(path)
  if f then
    local config = f:read "*a"
    f:close()

    local toml_edit = require "toml_edit"
    local lua_tbl = toml_edit.parse_as_tbl(config)
    return lua_tbl["group"] or {}
  else
    return {}
  end
end

function M.open_notebook() vim.cmd("e " .. get_zk_notebook_dir() .. "/index.md") end

function M.open_note(path, opts)
  opts = opts or {}
  assert(path ~= nil and path ~= "", "No text for note path")
  -- assert(dir ~= nil and dir ~= "", "No text for note dir")
  -- assert(group ~= nil and dir ~= "", "not text for group and dir")
  local pathDir, filename = path:match "([^,]+)/([^,]+)"

  if filename == nil then filename = path end

  -- assert(path ~= nil or dir ~= nil, "No directory for the note")
  -- assert(group ~= nil or dir ~= nil, "No group for the note")

  local title = titleize(parse_text(filename))

  zk.new { title = title, group = opts.group, dir = opts.dir or pathDir }
end

function M.grep_notes(opts)
  opts = opts or {}

  local dir = get_zk_notebook_dir()
  local collection = {}
  local list_opts = { select = { "title", "path", "absPath" } }

  require("zk.api").list(dir, list_opts, function(_, notes)
    for _, note in ipairs(notes) do
      -- local prefix = string.gmatch(note.path, "([%w-_]+)/")()
      local title = note.title
      -- if prefix then
      --   title = prefix .. ": " .. note.title
      -- else
      --   title = note.title
      -- end
      collection[note.absPath] = title
    end
  end)
  local options = vim.tbl_deep_extend("force", {
    prompt_title = "Notes",
    search_dirs = { dir },
    disable_coordinates = true,
    path_display = function(_, path) return collection[path] end,
  }, {})
  require("telescope.builtin").live_grep(options)
end

function M.pick_zk_group(opts)
  local groups = get_zk_config_groups()
  local groupNames = {}

  if next(groups) == nil then
    print "No groups found"
    M.find_or_create_note()
    return
  end

  table.insert(groupNames, "")
  for k, _ in pairs(groups) do
    table.insert(groupNames, k)
  end

  opts = opts or {}

  pickers
    .new(opts, {
      prompt_title = "Groups",
      finder = finders.new_table {
        results = groupNames,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = state.get_selected_entry()
          local group, dir
          if selection then
            group = selection[1]
            if group == "" then group = nil end
            if group then
              if groups[group] and groups[group]["paths"] then dir = groups[group]["paths"][1] end
            end
          end

          M.find_or_create_note { group = group, dir = dir }
        end)

        return true
      end,
    })
    :find()
end

function M.find_or_create_note(opts)
  opts = opts or {}
  local group = opts.group
  local dir = opts.dir or get_zk_notebook_dir()
  local location = util.get_lsp_location_from_selection()

  local selected_text = util.get_selected_text()

  if selected_text ~= "" then
    if string.match(selected_text, "(.-)\n") then
      opts.content = selected_text
    else
      opts.title = selected_text
    end

    if opts.inline == true then
      opts.inline = nil
      opts.dryRun = true
      opts.insertContentAtLocation = location
    else
      opts.insertLinkAtLocation = location
    end

    zk.new(opts)

    return
  end

  -- local mode = vim.fn.mode()

  local cwd = get_zk_notebook_dir()
  local options = vim.tbl_deep_extend("force", {
    prompt_title = "Notes",
    attach_mappings = function(_, map)
      actions.select_default:replace(function() return true end)

      local run_expand_command = function(prompt_bufnr)
        local selection = state.get_selected_entry()
        local text

        if selection ~= nil then
          local note_name = selection.value.title
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
          M.open_note(selection.value.path, { dir = dir, group = group })
          actions.close(prompt_bufnr)
        else
          vim.ui.input({ prompt = "Do you want to create note " .. input_text .. " (y/N) " }, function(input)
            if input ~= nil and input == "y" then M.open_note(input_text, { dir = dir, group = group }) end

            actions.close(prompt_bufnr)
          end)
        end
      end

      local create_note = function(prompt_bufnr, _)
        local input_text = state.get_current_line()
        M.open_note(input_text, { dir = dir, group = group })

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

  zk.edit({ notebook_path = cwd, sort = { "modified" } }, { picker = "telescope", telescope = options })
end

function M.open_notes()
  local path = vim.loop.cwd()
  local options = {
    sort = { "modified" },
    preview_title = "File preview",
    attach_mappings = function(prompt_bufnr, map)
      local select_note = function()
        local entry = state.get_selected_entry()

        if entry == nil then
          print "No selection"
        else
          actions.select_default()
        end
        return false
      end

      map("i", "<CR>", select_note)
      map("n", "<CR>", select_note)
      return true
    end,
  }
  zk.edit({ path = path, sort = { "modified" } }, { picker = "telescope", telescope = options })
end

function M.find_or_create_note_without_picker(opts)
  assert(opts.title ~= nil, "Missing title")
  assert(opts.dir ~= nil, "Missing dir")
  assert(opts.group ~= nil, "Missing group")

  zk.new {
    title = opts.title,
    group = opts.group,
    dir = opts.dir,
    -- date = opts.date,
  }
end

return M
