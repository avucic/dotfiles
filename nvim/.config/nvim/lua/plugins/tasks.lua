return {
  {
    "phrmendes/todotxt.nvim",
    cmd = { "TodoTxt", "DoneTxt" },
    opts = {
      todotxt = "/Users/vucinjo/Dropbox/todo/todo.txt",
      donetxt = "/Users/vucinjo/Dropbox/todo/done.txt",
      ghost_text = {
        enable = true,
        mappings = {
          ["(A)"] = "now",
          ["(B)"] = "next",
          ["(C)"] = "today",
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "todotxt" },
          highlight = { enable = true },
        }
      end,

      dependencies = {
        "nvim-telescope/telescope.nvim",
        {
          "AstroNvim/astrocore",
          opts = function(_, opts)
            local maps = opts.mappings
            maps.n["<Leader>tt"] = { "<cmd>TodoTxt<cr>", desc = "TodoTxt" }
          end,
        },
      },
    },
  },
  {
    -- "atiladefreitas/dooing",
    -- config = function()
    --   require("dooing").setup {
    --     per_project = {
    --       enabled = true, -- Enable per-project todos
    --       default_filename = ".tasks.json", -- Default filename for project todos
    --       auto_gitignore = false, -- Auto-add to .gitignore (true/false/"prompt")
    --       on_missing = "prompt", -- What to do when file missing ("prompt"/"auto_create")
    --       auto_open_project_todos = false, -- Auto-open project todos on startup if they exist
    --     },
    --     keymaps = {
    --       toggle_window = "<leader>nt", -- Toggle global todos
    --       open_project_todo = "<leader>nT", -- Toggle project-specific todos
    --       new_todo = "i",
    --       create_nested_task = "<leader>ntn", -- Create nested subtask under current todo
    --       toggle_todo = "x",
    --       delete_todo = "d",
    --       delete_completed = "D",
    --       close_window = "q",
    --       undo_delete = "u",
    --       add_due_date = "H",
    --       remove_due_date = "r",
    --       toggle_help = "?",
    --       toggle_tags = "t",
    --       toggle_priority = "<Space>",
    --       clear_filter = "c",
    --       edit_todo = "e",
    --       edit_tag = "e",
    --       edit_priorities = "p",
    --       delete_tag = "d",
    --       search_todos = "/",
    --       add_time_estimation = "T",
    --       remove_time_estimation = "R",
    --       import_todos = "I",
    --       export_todos = "E",
    --       remove_duplicates = "<leader>D",
    --       open_todo_scratchpad = "<leader>p",
    --       refresh_todos = "f",
    --       share_todos = "s",
    --     },
    --   }
    -- end,
  },
}
