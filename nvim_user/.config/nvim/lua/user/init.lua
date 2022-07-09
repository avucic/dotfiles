local ok, _ = pcall(require, "user.core.utils")
if not ok then
  return {}
end

local config = require("user.core.utils").load_module("user.core.config")
if config then
  return config.config()
end
