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
          post_write_note = function(note)
            local vault = tostring(require("obsidian.api").resolve_workspace_dir())
            vim.fn.jobstart({
              "git",
              "-C",
              vault,
              "add",
              "-A",
            }, {
              on_exit = function()
                vim.fn.jobstart({
                  "git",
                  "-C",
                  vault,
                  "commit",
                  "-m",
                  "sync: " .. os.date("%Y-%m-%d %H:%M"),
                }, {
                  on_exit = function()
                    vim.fn.jobstart({ "git", "-C", vault, "push" })
                  end,
                })
              end,
            })
          end,
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

  -- ── notes sync ───────────────────────────────────────────────────────────────
  {
    dir = "~",
    lazy = false,
    config = function()
      local function sync_notes()
        local notes_dir = os.getenv("NOTES_DIR") or vim.fn.expand("~/Documents/Notes")
        -- pull first
        vim.fn.jobstart({ "git", "-C", notes_dir, "pull", "--rebase" }, {
          on_exit = function()
            -- then push local changes if any
            vim.fn.jobstart({ "git", "-C", notes_dir, "status", "--porcelain" }, {
              stdout_buffered = true,
              on_stdout = function(_, data)
                local output = table.concat(data or {}, "")
                if output ~= "" then
                  vim.notify("Syncing notes...", vim.log.levels.INFO)
                  vim.fn.jobstart({ "git", "-C", notes_dir, "add", "-A" }, {
                    on_exit = function()
                      vim.fn.jobstart(
                        { "git", "-C", notes_dir, "commit", "-m", "sync: " .. os.date("%Y-%m-%d %H:%M") },
                        {
                          on_exit = function()
                            vim.fn.jobstart({ "git", "-C", notes_dir, "push" }, {
                              on_exit = function()
                                vim.notify("Notes synced", vim.log.levels.INFO)
                              end,
                            })
                          end,
                        }
                      )
                    end,
                  })
                end
              end,
            })
          end,
        })
      end

      vim.api.nvim_create_user_command("NoteSync", sync_notes, { desc = "Sync notes to git" })
      vim.keymap.set("n", "<Leader>nS", sync_notes, { desc = "Sync notes" })

      local function pull_notes()
        local notes_dir = os.getenv("NOTES_DIR") or vim.fn.expand("~/Documents/Notes")
        vim.fn.jobstart({ "git", "-C", notes_dir, "pull", "--rebase" })
      end

      vim.api.nvim_create_autocmd("VimEnter", { callback = pull_notes })
      vim.api.nvim_create_autocmd("FocusGained", { callback = sync_notes })
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
