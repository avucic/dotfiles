return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  keys = {
    { "<leader>nn", "<cmd>Obsidian<cr>", desc = "Open" },
    { "<leader>no", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
    { "<leader>nN", "<cmd>Obsidian links<cr>", desc = "New From Template" },
    { "<leader>nw", "<cmd>Obsidian search<cr>", desc = "Search" },
    { "<leader>nb", "<cmd>Obsidian backlinks<cr>", desc = "Backinks" },
    { "<leader>nl", "<cmd>Obsidian links<cr>", desc = "Links" },
    { "<leader>nd", desc = "Day" },
    { "<leader>ndt", "<cmd>Obsidian today<cr>", desc = "Today" },
    { "<leader>ndy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday" },
  },
  opts = {
    legacy_commands = false,
    note_id_func = function(title)
      local lower_title = string.lower(title)
      return string.gsub(lower_title, "%s+", "-")
      --:gsub(" ", "_")
    end,
    -- note_id_func = function(title)
    --   local lower_title = string.lower(title)
    --   local kebab_case_title = string.gsub(lower_title, "%s+", "-")
    --   local timestamp = os.date "%Y%m%d%H%M" -- Format: YYYYMMDDHHmm
    --   return timestamp .. "-" .. kebab_case_title
    -- end,
    note_frontmatter_func = function(note)
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
      if #note.tags == 0 then table.insert(out.tags, "empty") end

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
    checkbox = {
      enabled = true,
      create_new = true,
      order = { " ", "x" },
    },
    workspaces = {
      {
        name = "work",
        path = "/Users/vucinjo/Dropbox/vaults/work",
      },
      {
        name = "personal",
        path = "/Users/vucinjo/Dropbox/vaults/me",
      },
    },
    completion = {
      -- Set to false to disable completion.
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },

    -- see below for full list of options 👇
    preferred_link_style = "markdown",
    open_notes_in = "current",
    -- templates = {
    --   folder = "templates",
    -- },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
      substitutions = {
        year = function() return os.date("%Y", os.time()) end,
        month = function() return os.date("%B", os.time()) end,
        -- author = function() return os.capture("rg -N '(name = )(.*)' -or '$2' ~/.gitconfig | head -1", false) end,
        fulldate = function() return os.date("%A %dth %B %Y", os.time()) end,
        week = function() return os.date "W%V" end,
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      -- /Users/awjl/Documents/notes/90-Inbox/dailies
      folder = "daily",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "#daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
    callbacks = {
      enter_note = function(_, note)
        vim.keymap.set("n", "<leader>oh", "<cmd>Obsidian toggle_checkbox<cr>", {
          buffer = note.bufnr,
          desc = "c[H]eckbox",
        })
        vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian open<CR>", {
          buffer = note.bufnr,
          desc = "[O]pen",
        })
        vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<CR>", {
          buffer = note.bufnr,
          desc = "[N]ew",
        })
        vim.keymap.set("n", "<leader>os", "<cmd>Obsidian quick_switch<CR>", {
          buffer = note.bufnr,
          desc = "[S]witch notes",
        })
        vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", {
          buffer = note.bufnr,
          desc = "[B]acklinks to current",
        })
        vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian tags<CR>", {
          buffer = note.bufnr,
          desc = "[T]ags",
        })
        vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian links<CR>", {
          buffer = note.bufnr,
          desc = "[L]inks",
        })
        vim.keymap.set("v", "<leader>ox", "<cmd>Obsidian extract_note<CR>", {
          buffer = note.bufnr,
          desc = "E[X]tract",
        })
        vim.keymap.set("n", "<leader>ow", "<cmd>Obsidian workspace<CR>", {
          buffer = note.bufnr,
          desc = "[W]orkspace switch",
        })
        vim.keymap.set("n", "<leader>oi", "<cmd>Obsidian paste_img<CR>", {
          buffer = note.bufnr,
          desc = "[I]mg paste",
        })
        vim.keymap.set("n", "<leader>or", "<cmd>Obsidian rename<CR>", {
          buffer = note.bufnr,
          desc = "[R]ename",
        })
        vim.keymap.set("n", "<leader>oe", "<cmd>Obsidian template<CR>", {
          buffer = note.bufnr,
          desc = "Insert t[E]mplate",
        })
        vim.keymap.set("n", "<leader>om", "<cmd>Obsidian new_from_template<CR>", {
          buffer = note.bufnr,
          desc = "New from te[M]plate",
        })
        vim.keymap.set("n", "<leader>oc", "<cmd>Obsidian toc<CR>", {
          buffer = note.bufnr,
          desc = "TO[C]",
        })
        vim.keymap.set("n", "<leader>of", "<cmd>Obsidian search<CR>", {
          buffer = note.bufnr,
          desc = "[F]ind",
        })
      end,
    },
  },
}
