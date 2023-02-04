if vim.env.SKIP_USER_CONFIG ~= "true" then
  local ok, _ = pcall(require, "user.core.utils")

  if not ok then
    return {}
  end

  -- return config
  local ok, config = pcall(require, "user.core.config")
  if ok then
    return config.config()
  end
else
  return {}
end
