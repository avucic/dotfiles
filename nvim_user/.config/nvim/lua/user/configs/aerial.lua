local M = {}

function M.config()
  return {
    manage_folds = true,
    keymaps = {
      ["{"] = "actions.prev",
      ["}"] = "actions.next",
      ["[["] = "actions.prev_up",
      ["]]"] = "actions.next_up",
    },
  }
end

return M
