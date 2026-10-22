return {
  -- ── obsidian.nvim ─────────────────────────────────────────────────────────────
  {
    "obsidian-nvim/obsidian.nvim",
    ft = { "markdown" },
    cmd = { "Obsidian" },
    keys = {
      { "<Leader>no", "<cmd>Obsidian<cr>", desc = "Obsidian" },
      { "<Leader>nt", "<cmd>Obsidian tags<cr>", desc = "Tags" },
      { "<Leader>nn", "<cmd>Obsidian new<cr>", desc = "New note" },
      { "<Leader>nN", "<cmd>Obsidian new_from_template<cr>", desc = "New from template" },
      { "<Leader>nf", "<cmd>Obsidian search<cr>", desc = "Search notes" },
      { "<Leader>np", "<cmd>Obsidian workspace<cr>", desc = "Workspace" },
      { "<Leader>ndt", "<cmd>Obsidian today<cr>", desc = "Today" },
      { "<Leader>ndy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local Util = require("utils.core")
      require("obsidian").setup({
        ui = { enable = false },
        legacy_commands = false,
        picker = { name = "snacks.picker" },

        note_id_func = function(title)
          local suffix = ""
          if title then
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return suffix
        end,

        link = { format = "shortest", style = "markdown" },
        workspaces = (function()
          local base = vim.fn.expand(os.getenv("NOTES_DIR") or "~/Documents/Notes")
          return {
            { name = "work", path = base .. "/work" },
            { name = "me", path = base .. "/me" },
          }
        end)(),

        open_notes_in = "current",
        notes_subdir = "notes",
        new_notes_location = "notes_subdir",

        templates = {
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
          folder = "templates",
        },

        daily_notes = {
          folder = "daily",
          date_format = "%Y-%m-%d",
          alias_format = "%B %-d, %Y",
        },

        attachments = { folder = "assets" },

        callbacks = {
          enter_note = function(note)
            if not note then
              return
            end
            Util.setup_keymaps_and_help_popup(note.bufnr, {
              { key = "gd", rhs = "<cmd>Obsidian follow_link<cr>", desc = "Follow link" },
              { key = "<C-Space>", rhs = "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox" },
              { key = "<Leader>oo", rhs = "<cmd>Obsidian open<cr>", desc = "Open in Obsidian" },
              { key = "<Leader>os", rhs = "<cmd>Obsidian quick_switch<cr>", desc = "Switch notes" },
              { key = "<Leader>ob", rhs = "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
              { key = "<Leader>ol", rhs = "<cmd>Obsidian links<cr>", desc = "Links" },
              { key = "<Leader>ox", rhs = "<cmd>Obsidian extract_note<cr>", desc = "Extract", mode = "v" },
              { key = "<Leader>oi", rhs = "<cmd>Obsidian paste_img<cr>", desc = "Paste image" },
              { key = "<Leader>or", rhs = "<cmd>Obsidian rename<cr>", desc = "Rename" },
              { key = "<Leader>oe", rhs = "<cmd>Obsidian template<cr>", desc = "Insert template" },
              { key = "<Leader>oT", rhs = "<cmd>Obsidian toc<cr>", desc = "TOC" },
              { key = "<Leader>of", rhs = "<cmd>Obsidian search<cr>", desc = "Find" },
            }, "Obsidian keymaps")
          end,
        },
      })
    end,
  },

  -- ── zk-nvim ───────────────────────────────────────────────────────────────────
  {
    "zk-org/zk-nvim",
    cmd = { "ZkNotes", "ZkTags", "ZkNew", "ZkMatch" },
    config = function()
      require("zk").setup({
        picker = "snacks",
        lsp = { config = { cmd = { "zk", "lsp" } } },
      })
    end,
  },

  -- ── render-markdown ───────────────────────────────────────────────────────────
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown", "codecompanion" },
        render_modes = { "n", "c" },
        code = { sign = false },
      })
    end,
  },
}
