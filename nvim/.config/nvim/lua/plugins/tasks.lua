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

    keys = {
      { "<leader>nt", "<cmd>TodoTxt<cr>", desc = "Toggle Todos" },
      { "<leader>ntn", "<cmd>TodoTxt new<cr>", desc = "New todo entry" },
      { "<leader>ntt", "<cmd>TodoTxt<cr>", desc = "Toggle todo.txt" },
      { "<leader>ntd", "<cmd>DoneTxt<cr>", desc = "Toggle done.txt" },
      { "<leader>ntg", "<cmd>TodoTxt ghost<cr>", desc = "Toggle ghost text" },
      { "<cr>", "<Plug>(TodoTxtToggleState)", desc = "Toggle task state" },
      { "<c-c>n", "<Plug>(TodoTxtCyclePriority)", desc = "Cycle priority" },
      { "<leader>ntm", "<Plug>(TodoTxtMoveDone)", desc = "Move done tasks" },
      { "<leader>nts", desc = "Sort tasks" },
      { "<leader>ntss", "<Plug>(TodoTxtSortTasks)", desc = "Sort tasks (default)" },
      { "<leader>ntsp", "<Plug>(TodoTxtSortByPriority)", desc = "Sort by priority" },
      { "<leader>ntsc", "<Plug>(TodoTxtSortByContext)", desc = "Sort by context" },
      { "<leader>ntsP", "<Plug>(TodoTxtSortByProject)", desc = "Sort by project" },
      { "<leader>ntsd", "<Plug>(TodoTxtSortByDueDate)", desc = "Sort by due date" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      config = function(_, opts)
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "todotxt" },
          highlight = { enable = true },
        }
      end,
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
