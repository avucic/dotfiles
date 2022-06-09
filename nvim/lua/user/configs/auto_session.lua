local M = {}

function M.config()
  local auto_session = require("user.utils").load_module("auto-session")

  auto_session.setup({
    log_level = "info",
    auto_session_suppress_dirs = { "~/", "~/Projects" },
    pre_save_cmds = { "Neotree close" },
    auto_restore_enabled = false,
  })
end

return M
