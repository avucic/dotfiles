local M = {}

function M.config()
  local autoSession = require("user.core.utils").load_module("auto-session")
  if not autoSession then
    return {}
  end

  autoSession.setup({
    log_level = "error",
    -- auto_session_enable_last_session = false,
    -- auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    -- auto_session_enabled = false,
    -- auto_save_enabled = false,
    auto_restore_enabled = false,
    -- auto_session_suppress_dirs = nil,
    pre_save_cmds = {
      "tabdo Neotree close",
      "ToggleTerm close",
    },
    post_restore_cmds = {
      "tabdo Neotree close",
    },
  })
end

return M
