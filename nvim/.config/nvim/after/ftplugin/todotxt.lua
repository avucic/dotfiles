local bufnr = vim.api.nvim_get_current_buf()
local util = require "core.utils"

-- Define your keymap configurations as a table
local todotxt_keymap_configs = {
  { key = "<Leader>n", rhs = "<cmd>TodoTxt new<cr>", desc = "New todo entry" },
  { key = "<Leader>d", rhs = "<cmd>DoneTxt<cr>", desc = "Toggle done.txt" },
  { key = "<c-t>g", rhs = "<cmd>TodoTxt ghost<cr>", desc = "Toggle ghost text" },
  { key = "<cr>", rhs = "<Plug>(TodoTxtToggleState)", desc = "Toggle task state" },
  { key = "<c-c>n", rhs = "<Plug>(TodoTxtCyclePriority)", desc = "Cycle priority" },
  { key = "<Leader>x", rhs = "<Plug>(TodoTxtMoveDone)", desc = "Move done tasks" },
  { key = "<Leader>ss", rhs = "<Plug>(TodoTxtSortTasks)", desc = "Sort tasks (default)" },
  { key = "<Leader>sp", rhs = "<Plug>(TodoTxtSortByPriority)", desc = "Sort by priority" },
  { key = "<Leader>sc", rhs = "<Plug>(TodoTxtSortByContext)", desc = "Sort by context" },
  { key = "<Leader>sP", rhs = "<Plug>(TodoTxtSortByProject)", desc = "Sort by project" },
  { key = "<Leader>sd", rhs = "<Plug>(TodoTxtSortByDueDate)", desc = "Sort by due date" },
}

util.setup_keymaps_and_help_popup(bufnr, todotxt_keymap_configs, "--- Todo.txt Keymaps ---")
