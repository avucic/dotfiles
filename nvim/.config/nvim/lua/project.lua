-- Per-project Neovim configuration via .nvim.lua (exrc).
-- Applied on VimEnter (after exrc has run) so vim.g.project is always set.
--
-- Usage in .nvim.lua:
--
--   require('project').setup({
--     ai_adapter             = 'anthropic',
--     git_browse_main_branch = 'main',
--     disable_format_on_save = true,
--     formatters  = { typescript = { 'prettierd' } },
--     linters     = { javascript = { 'eslint_d' } },
--     lsp = {
--       disable_formatting = { 'ts_ls' },
--       servers = {
--         ts_ls = { settings = { typescript = { inlayHints = { enabled = 'all' } } } },
--       },
--     },
--     mason_tools = { 'eslint-lsp', 'prettierd' },
--     lsp_servers = { 'ts_ls', 'eslint' },
--   })
--
-- Legacy: setting vim.g.project = { ... } directly still works.

---@class ProjectLspConfig
---@field disable_formatting? string[]           LSP server names that lose formatting capability
---@field servers?            table<string,table> Per-server settings merged via vim.lsp.config()

---@class ProjectConfig
---@field ai_adapter?             string                 CodeCompanion adapter ('anthropic', 'gemini', …)
---@field git_browse_main_branch? string                 Branch for <Leader>gO (default: 'master')
---@field disable_format_on_save? boolean                Disable conform format-on-save
---@field formatters?             table<string,string[]> Override conform formatters_by_ft
---@field linters?                table<string,string[]> Override nvim-lint linters_by_ft
---@field lsp?                    ProjectLspConfig
---@field mason_tools?            string[]               Extra Mason tools to install on start
---@field lsp_servers?            string[]               Extra LSP servers to enable
---@field disable_formatters?     string[]               Formatter names to remove from all filetypes
---@field custom_other_mappings?  (string|table)[]       Extra other.nvim file mappings (preset name or mapping table)

local M = {}

-- .nvim.lua API: declare project config (merges with any existing value)
---@param opts ProjectConfig
function M.setup(opts)
  vim.g.project = vim.tbl_deep_extend('force', vim.g.project or {}, opts or {})
end

-- ── private applicators ───────────────────────────────────────────────────────

local function apply_lsp(project)
  local lsp = project.lsp or {}
  for name, cfg in pairs(lsp.servers or {}) do
    vim.lsp.config(name, cfg)
  end
  local servers = project.lsp_servers or {}
  if #servers > 0 then
    vim.lsp.enable(servers)
  end
end

local function apply_mason(project)
  local tools = project.mason_tools or {}
  if #tools == 0 then return end
  local ok, installer = pcall(require, 'mason-tool-installer')
  if not ok then return end
  local in_remote = vim.env.DEVCONTAINER ~= nil
    or vim.env.REMOTE_CONTAINERS ~= nil
    or vim.env.REMOTE_NVIM ~= nil
  installer.setup({ ensure_installed = tools, run_on_start = not in_remote })
end

local function apply_formatters(project)
  local overrides = project.formatters or {}
  local disabled = project.disable_formatters or {}
  if vim.tbl_isempty(overrides) and #disabled == 0 then return end
  local ok, conform = pcall(require, 'conform')
  if not ok then return end
  if not vim.tbl_isempty(overrides) then
    conform.formatters_by_ft = vim.tbl_extend('force', conform.formatters_by_ft, overrides)
  end
  if #disabled > 0 then
    local disabled_set = {}
    for _, name in ipairs(disabled) do disabled_set[name] = true end
    for ft, formatters in pairs(conform.formatters_by_ft) do
      conform.formatters_by_ft[ft] = vim.tbl_filter(function(f) return not disabled_set[f] end, formatters)
    end
  end
end

local function apply_linters(project)
  local overrides = project.linters or {}
  if vim.tbl_isempty(overrides) then return end
  local ok, lint = pcall(require, 'lint')
  if not ok then return end
  lint.linters_by_ft = vim.tbl_extend('force', lint.linters_by_ft, overrides)
end

-- ── called on VimEnter from plugins/init.lua ─────────────────────────────────

function M.apply()
  local project = vim.g.project or {}
  if vim.tbl_isempty(project) then return end

  apply_lsp(project)
  apply_mason(project)
  apply_formatters(project)
  apply_linters(project)

  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyLoad',
    callback = function(ev)
      if ev.data == 'conform.nvim' then apply_formatters(project) end
      if ev.data == 'nvim-lint'   then apply_linters(project) end
    end,
  })
end

return M
