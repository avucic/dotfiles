local M = {}

local function root()
  return vim.fs.root(0, {
    'eslint.config.js', 'eslint.config.mjs', 'eslint.config.cjs',
    'package.json',
    'pnpm-workspace.yaml',
    '.git',
  })
end

local function exists(file)
  local r = root()
  return r and vim.uv.fs_stat(r .. '/' .. file)
end

function M.root() return root() end
function M.has_eslint()
  return exists('eslint.config.js') or exists('eslint.config.mjs') or exists('eslint.config.cjs')
end

function M.find_tsconfig()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then return nil end
  local results = vim.fs.find({ 'tsconfig.app.json', 'tsconfig.json' }, {
    upward = true,
    path   = name,
  })
  return results[1]
end

function M.is_typescript() return M.find_tsconfig() ~= nil end

function M.ts_root()
  local config = M.find_tsconfig()
  return config and vim.fs.dirname(config) or nil
end

function M.workspace_root()
  return vim.fs.root(0, {
    'pnpm-workspace.yaml',
    'package.json',
    'eslint.config.js',
    '.git',
  })
end

function M.find_eslint_config()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then return nil end
  local result = vim.fs.find({
    'eslint.config.js', 'eslint.config.mjs', 'eslint.config.cjs',
    '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json',
  }, { upward = true, path = name })
  return result[1]
end

function M.eslint_root()
  local config = M.find_eslint_config()
  return config and vim.fs.dirname(config) or nil
end

return M
