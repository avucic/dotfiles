if vim.env.SKIP_USER_CONFIG ~= "true" then
  local ok, _ = pcall(require, "user.core.utils")

  if not ok then
    return {}
  end

  -- return config
  local config = require("user.core.utils").load_module("user.core.config")
  if config then
    return config.config()
  end
else
  return {}
end
