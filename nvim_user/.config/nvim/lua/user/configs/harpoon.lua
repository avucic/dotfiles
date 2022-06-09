local M = {}

function M.config()
  require("user.utils").load_module("harpoon")
  require("user.utils").load_module("telescope")
  require("telescope").load_extension("harpoon")
end

return M
