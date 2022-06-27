local ok, utils = pcall(require, "user.utils")
if not ok then
  return {}
end

local config = require("user.utils").load_module("user.config")
return config.config()