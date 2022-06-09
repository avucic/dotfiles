local M = {}

function M.config()
  local _null_ls = require("user.utils").load_module("nvim-tree")

  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_respect_buf_cwd = 1

  local tree_cb = require("nvim-tree.config").nvim_tree_callback
  -- Make sure nvim-tree loads itself when lazy loaded
  -- vim.defer_fn(require("nvim-tree").refresh, 25)

  return {
    -- preserve_window_proportions = true,
    disable_netrw = true,
    hijack_netrw = true,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },

    view = {
      width = 35,
      auto_resize = true,
      mappings = {
        -- custom only false will merge the list with the default mappings
        -- if true, it will only use your list to set the mappings
        custom_only = false,
        -- list of mappings to set on the tree manually
        list = {
          -- { key = "l", cb = tree_cb "edit" },
          { key = { "<CR>", "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
          { key = "<C-v>", cb = tree_cb("vsplit") },
          { key = "<C-x>", cb = tree_cb("split") },
          { key = "<C-t>", cb = tree_cb("tabnew") },
          -- { key = "h", cb = tree_cb "close_node" },
          { key = "<S-CR>", cb = tree_cb("close_node") },
          { key = "<Tab>", cb = tree_cb("preview") },
          { key = "I", cb = tree_cb("toggle_ignored") },
          { key = "H", cb = tree_cb("toggle_dotfiles") },
          { key = "R", cb = tree_cb("refresh") },
          { key = "a", cb = tree_cb("create") },
          { key = "d", cb = tree_cb("remove") },
          { key = "r", cb = tree_cb("rename") },
          { key = "<C-r>", cb = tree_cb("full_rename") },
          { key = "x", cb = tree_cb("cut") },
          { key = "c", cb = tree_cb("copy") },
          { key = "p", cb = tree_cb("paste") },
          { key = "[c", cb = tree_cb("prev_git_item") },
          { key = "]c", cb = tree_cb("next_git_item") },
          { key = "-", cb = tree_cb("dir_up") },
          { key = "q", cb = tree_cb("close") },
          { key = "?", cb = tree_cb("toggle_help") },
        },
      },
    },
  }
end

return M
