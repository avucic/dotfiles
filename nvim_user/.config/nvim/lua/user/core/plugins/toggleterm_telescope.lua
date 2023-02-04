-- credits to https://github.com/da-moon/telescope-toggleterm.nvim
local M = {}

local pickers, finders, actions, actions_state, conf
if pcall(require, "telescope") then
  pickers = require("telescope.pickers")
  finders = require("telescope.finders")
  actions = require("telescope.actions")
  actions_state = require("telescope.actions.state")
  conf = require("telescope.config").values
else
  error("Cannot find telescope!")
end

local toggleterm = require("user.core.utils").load_module("toggleterm")
if not toggleterm then
  error("Cannot find toggleterm!")
end

local function exit_terminal(prompt_bufnr)
  local selection = actions_state.get_selected_entry()
  if selection == nil then
    return
  end
  local bufnr = selection.value.bufnr
  local current_picker = actions_state.get_current_picker(prompt_bufnr)
  current_picker:delete_selection(function()
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end)
end

function M.open()
  local terminals = require("toggleterm.terminal").get_all()
  local opts = {}

  pickers
    .new(opts, {
      prompt_title = "Terminal Buffers",
      finder = finders.new_table({
        results = terminals,
        entry_maker = function(entry)
          return {
            value = entry,
            text = tostring(entry.bufnr),
            display = tostring(entry.display_name or entry.name),
            ordinal = tostring(entry.bufnr),
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = actions_state.get_selected_entry()
          if selection == nil then
            return
          end

          actions.close(prompt_bufnr)
          vim.defer_fn(function()
            local id = selection.value.id

            local ok, result = pcall(vim.cmd, tostring(id) .. "ToggleTerm")
            if not ok then
              vim.notify(result, "error")
            end
          end, 100)
        end)
        -- ╭────────────────────────────────────────────────────────────────────╮
        -- │                           setup mappings                           │
        -- ╰────────────────────────────────────────────────────────────────────╯
        local update_counter = function()
          vim.g._terminal_counter = vim.g._terminal_counter - 1
        end

        local mappings = {
          ["dd"] = exit_terminal,
        }
        for keybind, action in pairs(mappings) do
          map("n", keybind, function()
            action(prompt_bufnr)
            update_counter()
          end)
          map("i", keybind, function()
            action(prompt_bufnr)
            update_counter()
          end)
        end
        return true
      end,
    })
    :find()
end

return M
