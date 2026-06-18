local M = {}

local function root()
  return vim.fs.root(0, {
    "eslint.config.js",
    "package.json",
    "pnpm-workspace.yaml",
    ".git",
  })
end

local function exists(file)
  local r = root()
  return r and vim.uv.fs_stat(r .. "/" .. file)
end

function M.root() return root() end

function M.has_eslint() return exists "eslint.config.js" end
---@return string|nil absolute path to tsconfig
function M.find_tsconfig()
  local results = vim.fs.find({ "tsconfig.app.json", "tsconfig.json" }, {
    upward = true,
    path = vim.api.nvim_buf_get_name(0),
  })

  return results[1] -- nil if not found
end

--- Returns true if current buffer belongs to TS project
---@return boolean
function M.is_typescript() return M.find_tsconfig() ~= nil end

--- Directory containing nearest tsconfig
---@return string|nil
function M.ts_root()
  local config = M.find_tsconfig()
  return config and vim.fs.dirname(config) or nil
end

--- Detect monorepo/workspace root
---@return string|nil
function M.workspace_root()
  return vim.fs.root(0, {
    "pnpm-workspace.yaml",
    "package.json",
    "eslint.config.js",
    ".git",
  })
end

function M.find_eslint_config()
  local result = vim.fs.find({
    "eslint.config.js",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
  }, {
    upward = true,
    path = vim.api.nvim_buf_get_name(0),
  })

  return result[1]
end

---------------------------------------------------------------------
-- Directory containing eslint config
---------------------------------------------------------------------
function M.eslint_root()
  local config = M.find_eslint_config()
  return config and vim.fs.dirname(config) or nil
end

return M
