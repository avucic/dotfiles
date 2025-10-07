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
      local kebab_case_title = string.gsub(lower_title, "%s+", "-")
      local timestamp = os.date "%Y%m%d%H%M" -- Format: YYYYMMDDHHmm
      return timestamp .. "-" .. kebab_case_title
    end,
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
    templates = {
      folder = "templates",
    },
  },
}
