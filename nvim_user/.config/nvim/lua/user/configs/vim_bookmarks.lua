local M = {}

function M.setup()
  vim.g.bookmark_save_per_working_dir = false
  -- vim.g.bookmark_auto_save_file = vim.fn.getcwd() .. "/.vim-bookmarks"
  vim.g.bookmark_auto_save = true
end

function M.config(_)
  -- local telescope = require("user.core.utils").load_module("telescope")
  -- if not telescope then
  --   return
  -- end

  -- telescope.load_extension("vim_bookmarks")
  -- local _vim_bookmarks = require("user.core.utils").load_module("vim_bookmarks")
end

function M.open_bookmarks_workaround()
  local telescope = require("telescope")
  local bookmark_actions = telescope.extensions.vim_bookmarks.actions
  telescope.extensions.vim_bookmarks.all({
    attach_mappings = function(_, map)
      map("n", "dd", bookmark_actions.delete_selected_or_at_cursor)
      map("n", "da", bookmark_actions.delete_all)

      return true
    end,
  })
end

return M
