local M = {}

-- vim.g.dbs = {
-- 	{
-- 		name = "Dev Postgres DB",
-- 		url = "postgresql://postgres:postgres@localhost:5432/dog_development?sslmode=disable",
-- 	},
--
-- 	{
-- 		name = "Test Postgres DB",
-- 		url = "postgresql://postgres@localhost/dog_test?sslmode=disable",
-- 	},
-- }

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local dropdown = require("telescope.themes").get_dropdown()
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")
local dbs = vim.g.dbs

local function enter(prompt_buffer)
  local selected = action_state.get_selected_entry()
  actions.close(prompt_buffer)
  local url = dbs[selected["index"]]["url"]
  vim.cmd([[DB ]] .. url .. [["]])
  vim.cmd([[DBUIToggle]])
end

function M.config()
  vim.g.db_ui_auto_execute_table_helpers = 1

  vim.cmd([[
  augroup _sql
    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
    autocmd FileType sql,mysql,plsql nnoremap <buffer> <C-q> :DBUIToggle<CR>
  augroup end
]])
end

function M.db_tasks()
  if not dbs then
    vim.notify("dbs variable not found", "error")
    return
  end

  local db_list_formatted = {}

  for _, task in pairs(dbs) do
    local current_task = task["name"]
    table.insert(db_list_formatted, current_task)
  end

  local opts = {
    prompt_title = "DB Connection",
    finder = finders.new_table(db_list_formatted),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map("i", "<CR>", enter)
      -- map("n", "<CR>", enter)
      return true
    end,
  }

  local db_tasks = pickers.new(dropdown, opts)
  db_tasks:find()
end

return M
