return {
  {
    -- "atiladefreitas/dooing",
    -- cmd = { "Dooing", "DooingLocal" },
    -- config = function() require("doing").setup() end,
    -- dependencies = {
    --   {
    --     "AstroNvim/astrocore",
    --     opts = function(_, opts)
    --       local doing = require "doing"
    --       local maps = opts.mappings
    --       maps.n["<Leader>nt"] = { desc = "Tasks" }
    --       maps.n["<Leader>nts"] = {
    --         function() vim.notify(doing.status(true), vim.log.levels.INFO, { title = "Doing:", icon = "" }) end,
    --         desc = "Status",
    --       }
    --       maps.n["<Leader>nta"] = { function() require("doing").add() end, desc = "Add task" }
    --       maps.n["<Leader>nte"] = { function() require("doing").edit() end, desc = "Edit task" }
    --       maps.n["<Leader>ntd"] = { function() require("doing").done() end, desc = "Mark as done" }
    --       maps.n["<Leader>ntt"] = { function() require("doing").toggle() end, desc = "Toggle" }
    --     end,
    --   },
    "atiladefreitas/dooing",
    config = function()
      require("dooing").setup {
        per_project = {
          enabled = true, -- Enable per-project todos
          default_filename = ".tasks.json", -- Default filename for project todos
          auto_gitignore = false, -- Auto-add to .gitignore (true/false/"prompt")
          on_missing = "prompt", -- What to do when file missing ("prompt"/"auto_create")
          auto_open_project_todos = false, -- Auto-open project todos on startup if they exist
        },
        keymaps = {
          toggle_window = "<leader>nt", -- Toggle global todos
          open_project_todo = "<leader>nT", -- Toggle project-specific todos
          new_todo = "i",
          create_nested_task = "<leader>ntn", -- Create nested subtask under current todo
          toggle_todo = "x",
          delete_todo = "d",
          delete_completed = "D",
          close_window = "q",
          undo_delete = "u",
          add_due_date = "H",
          remove_due_date = "r",
          toggle_help = "?",
          toggle_tags = "t",
          toggle_priority = "<Space>",
          clear_filter = "c",
          edit_todo = "e",
          edit_tag = "e",
          edit_priorities = "p",
          delete_tag = "d",
          search_todos = "/",
          add_time_estimation = "T",
          remove_time_estimation = "R",
          import_todos = "I",
          export_todos = "E",
          remove_duplicates = "<leader>D",
          open_todo_scratchpad = "<leader>p",
          refresh_todos = "f",
          share_todos = "s",
        },
      }
    end,

    -- {
    --   "rebelot/heirline.nvim",
    --   opts = function(_, opts)
    --     -- Ensure opts.statusline is a table
    --     local original_statusline = opts.statusline or {}
    --
    --     -- Add the new provider as a component to the statusline
    --     table.insert(opts.statusline, {
    --       provider = function()
    --         local doing = require "doing"
    --         return " " .. doing.status() .. " +" .. tostring(doing.tasks_left())
    --       end,
    --       update = { "BufEnter", "User", pattern = "TaskModified" },
    --     })
    --     -- opts.statusline = {
    --     --   { provider = "PREPEND" }, -- Align left
    --     --   { provider = "%=" }, -- Align left
    --     --   {
    --     --     provider = function()
    --     --       local doing = require "doing"
    --     --       return " " .. doing.status() .. " +" .. tostring(doing.tasks_left())
    --     --     end,
    --     --     update = { "BufEnter", "User", pattern = "TaskModified" },
    --     --   },
    --     --   { provider = "%=" }, -- Align right
    --     -- }
    --     --
    --     -- for _, v in ipairs(original_statusline) do
    --     --   table.insert(opts.statusline, v)
    --     -- end
    --   end,
    -- },
    -- },
  },
}
