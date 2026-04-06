local Util = require "utils.core"

local node_id_function = function(title)
  local lower_title = string.lower(title)
  local kebab_case_title = string.gsub(lower_title, "%s+", "-")
  local cleaned_string = kebab_case_title:gsub("[^%w-]", "")
  return cleaned_string
end

---@param opts { path: string, label: string, id: string|integer|?, anchor: obsidian.note.HeaderAnchor|?, block: obsidian.note.Block|? }
---@return string
local markdown_link_func = function(opts)
  local util = require "obsidian.util"
  local anchor = ""
  local header = ""
  if opts.anchor then
    anchor = opts.anchor.anchor
    header = util.format_anchor_label(opts.anchor)
  elseif opts.block then
    anchor = "#" .. opts.block.id
    header = "#" .. opts.block.id
  end

  local path = util.urlencode(vim.fs.basename(opts.path), { keep_path_sep = true })
  return string.format("[%s%s](%s%s)", opts.label, header, path, anchor)
end

local frontmatter_func = function(note)
  -- Add the title of the note as an alias.
  -- if note.title then
  --     note:add_alias(note.title)
  -- end

  -- date_created chooses today if non-existent
  local out = {
    id = note.id,
    aliases = note.aliases,
    tags = note.tags,
    date_created = note.date_created or os.date "%Y-%m-%d",
  }

  -- Adds a wip tag if doesn't exist
  if #note.tags == 0 then table.insert(out.tags, "note") end

  -- `note.metadata` contains any manually added fields in the frontmatter.
  -- So here we just make sure those fields are kept in the frontmatter.
  if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    for k, v in pairs(note.metadata) do
      out[k] = v
    end
  end

  return out
end

return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  cmd = { "Obsidian" },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>no"] = { "<cmd>Obsidian<cr>", desc = "Obsidian" }
        maps.n["<Leader>nt"] = { "<cmd>Obsidian tags<cr>", desc = "Open" }
        maps.n["<Leader>nn"] = { "<cmd>Obsidian new<cr>", desc = "Open" }
        maps.n["<Leader>nN"] = { "<cmd>Obsidian new_from_template<cr>", desc = "New From Template" }
        maps.n["<Leader>nf"] = { "<cmd>Obsidian search<cr>", desc = "Search" }
        maps.n["<Leader>nd"] = { name = "Day" }
        maps.n["<Leader>ndt"] = { "<cmd>Obsidian today<cr>", desc = "Today" }
        maps.n["<Leader>ndy"] = { "<cmd>Obsidian yesterday<cr>", desc = "Yesterday" }
        maps.n["<Leader>np"] = { "<cmd>Obsidian workspace<CR>", desc = "Workspace" }
      end,
    },
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    note_id_func = node_id_function,
    markdown_link_func = markdown_link_func,
    checkbox = {
      enabled = true,
      create_new = true,
      order = { " ", "x" },
    },
    frontmatter = {
      func = frontmatter_func,
    },
    workspaces = {
      {
        name = "personal",
        path = "/Users/vucinjo/Dropbox/vaults/me",
      },
    },
    completion = {
      -- Set to false to disable completion.
      blink = true,
      nvim_cmp = false,
      -- Trigger completion at 2 chars.
      min_chars = 2,
      -- match_case = true,
      -- create_new = true,
    },

    -- see below for full list of options 👇
    preferred_link_style = "markdown",
    -- Optional, determines how certain commands open notes. The valid options are:
    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - only open in a vertical split if a vsplit does not exist.
    -- 3. "hsplit" - only open in a horizontal split if a hsplit does not exist.
    -- 4. "vsplit_force" - always open a new vertical split if the file is not in the adjacent vsplit.
    -- 5. "hsplit_force" - always open a new hori
    open_notes_in = "current",
    -- templates = {
    --   folder = "templates",
    -- },
    notes_subdir = "01_Inbox",
    new_notes_location = "notes_subdir",
    templates = {
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
      folder = "templates",
      substitutions = {
        year = function() return os.date("%Y", os.time()) end,
        month = function() return os.date("%B", os.time()) end,
        -- author = function() return os.capture("rg -N '(name = )(.*)' -or '$2' ~/.gitconfig | head -1", false) end,
        fulldate = function() return os.date("%A %dth %B %Y", os.time()) end,
        week = function() return os.date "W%V" end,
      },
      customizations = {
        note = {
          notes_subdir = "02_Notes",
          note_id_func = node_id_function,
        },
        project = {
          notes_subdir = "04_Projects",
          note_id_func = node_id_function,
        },
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      -- /Users/awjl/Documents/notes/90-Inbox/dailies
      folder = "03_Daily",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "#daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
    attachments = {
      img_folder = "06_Assets/images",
    },
    callbacks = {
      enter_note = function(note)
        if note ~= nil then
          local keymap_configs = {
            { key = "gd", rhs = "<cmd>Obsidian follow_link<cr>", desc = "Follow link" },
            { key = "<Leader>oh", rhs = "<cmd>Obsidian toggle_checkbox<cr>", desc = "c[H]eckbox" },
            { key = "<Leader>oo", rhs = "<cmd>Obsidian open<CR>", desc = "[O]pen" },
            { key = "<Leader>os", rhs = "<cmd>Obsidian quick_switch<CR>", desc = "[S]witch notes" },
            { key = "<Leader>ob", rhs = "<cmd>Obsidian backlinks<CR>", desc = "[B]acklinks to current" },
            { key = "<Leader>ol", rhs = "<cmd>Obsidian links<CR>", desc = "[L]inks" },
            { key = "<Leader>ox", mode = "v", rhs = "<cmd>Obsidian extract_note<CR>", desc = "E[X]tract" },
            { key = "<Leader>oi", rhs = "<cmd>Obsidian paste_img<CR>", desc = "[I]mg paste" },
            { key = "<Leader>or", rhs = "<cmd>Obsidian rename<CR>", desc = "[R]ename" },
            { key = "<Leader>oe", rhs = "<cmd>Obsidian template<CR>", desc = "Insert t[E]mplate" },
            { key = "<Leader>oc", rhs = "<cmd>Obsidian toc<CR>", desc = "TO[C]" },
            { key = "<Leader>of", rhs = "<cmd>Obsidian search<CR>", desc = "[F]ind" },
          }

          Util.setup_keymaps_and_help_popup(note.bufnr, keymap_configs, "Keymaps")
        end
      end,
    },
  },
}
