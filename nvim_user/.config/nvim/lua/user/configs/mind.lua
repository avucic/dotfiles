local M = {}

function M.setup() end

function M.config()
  local mind = require("user.core.utils").load_module("mind")
  if not mind then
    return {}
  end

  mind.setup({
    persistence = {
      state_path = "~/Dropbox/Notes/mind.json",
      data_dir = "~/Dropbox/Notes",
    },
  })
end

return M
