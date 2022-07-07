local M = {}

function M.config()
  local neo_tree = require("user.utils").load_module("neo-tree")

  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_respect_buf_cwd = 1

  -- local tree_cb = require("nvim-tree.config").nvim_tree_callback
  -- Make sure nvim-tree loads itself when lazy loaded
  -- vim.defer_fn(require("nvim-tree").refresh, 25)

  return {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      follow_current_file = false,
    },
    window = {
      width = 40,
      mappings = {
        ["S"] = "split_with_window_picker",
        ["s"] = "vsplit_with_window_picker",
        w = function(state)
          local node = state.tree:get_node()
          local success, picker = pcall(require, "window-picker")
          if not success then
            print(
              "You'll need to install window-picker to use this command: https://github.com/s1n7ax/nvim-window-picker"
            )
            return
          end
          local picked_window_id = picker.pick_window()
          if picked_window_id then
            vim.api.nvim_set_current_win(picked_window_id)
            vim.cmd("edit " .. vim.fn.fnameescape(node.path))
          end
        end,
      },
    },
  }
end

return M
