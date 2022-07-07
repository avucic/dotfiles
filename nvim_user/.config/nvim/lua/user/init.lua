local ok, _ = pcall(require, "user.utils")
if not ok then
  return {}
end

local config = require("user.utils").load_module("user.config")

if config then
  return config.config()
end
