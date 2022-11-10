local M = {}

function M.config()
  local telescope = require("user.core.utils").load_module("telescope")
  if not telescope then
    return
  end

  telescope.load_extension("vim_bookmarks")
  local _vim_bookmarks = require("user.core.utils").load_module("vim_bookmarks")
  local bookmark_actions = telescope.extensions.vim_bookmarks.actions

  telescope.extensions.vim_bookmarks.all({
    attach_mappings = function(_, map)
      map("n", "dd", bookmark_actions.delete_selected_or_at_cursor)

      return true
    end,
  })
end

return M
