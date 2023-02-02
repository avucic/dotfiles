local M = {}

function M.config()
  local config = require("user.core.utils").load_module("config-local")
  if not config then
    return {}
  end

  config.setup({
    -- Default configuration (optional)
    config_files = { ".vimrc.lua", ".vimrc" }, -- Config file patterns to load (lua supported)
    hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
    autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
    commands_create = true, -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
    silent = true, -- Disable plugin messages (Config loaded/ignored)
    lookup_parents = false, -- Lookup config files in parent directories
  })
end

return M
