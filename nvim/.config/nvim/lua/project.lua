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
--       enable             = { 'eslint' },
--       disable            = { 'ts_ls' },
--       disable_formatting = { 'vtsls' },
--       servers = {
--         ts_ls = { settings = { typescript = { inlayHints = { enabled = 'all' } } } },
--       },
--     },
--     mason_tools     = { 'eslint-lsp', 'prettierd' },
--     container_tools = { 'eslint-lsp' },
--   })
--
-- Legacy: setting vim.g.project = { ... } directly still works.

---@class ProjectLspConfig
---@field enable?             string[]            LSP servers to enable for this project (no mason-lspconfig mapping)
---@field disable?            string[]            LSP servers to disable entirely for this project
---@field disable_formatting? string[]            LSP servers that lose formatting capability
---@field servers?            table<string,table> Per-server settings merged via vim.lsp.config()

---@class ProjectConfig
---@field ai_adapter?             string                 CodeCompanion adapter ('anthropic', 'gemini', …)
---@field ai_model?               string                 Override default model for the chosen adapter
---@field git_browse_main_branch? string                 Branch for <Leader>gO (default: 'master')
---@field disable_format_on_save? boolean                Disable conform format-on-save
---@field formatters?             table<string,string[]> Override conform formatters_by_ft
---@field linters?                table<string,string[]> Override nvim-lint linters_by_ft
---@field lsp?                    ProjectLspConfig
---@field mason_tools?            string[]               Mason tools to auto-install via Mason
---@field disable_formatters?     string[]               Formatter names to remove from all filetypes
---@field custom_other_mappings?  (string|table)[]       Extra other.nvim file mappings (preset name or mapping table)

local M = {}

-- .nvim.lua API: declare project config (merges with any existing value)
---@param opts ProjectConfig
function M.setup(opts)
  vim.g.project = vim.tbl_deep_extend("force", vim.g.project or {}, opts or {})
end

-- ── private applicators ───────────────────────────────────────────────────────

local function apply_lsp(project)
  local lsp = project.lsp or {}

  for name, cfg in pairs(lsp.servers or {}) do
    vim.lsp.config(name, cfg)
  end

  for _, server in ipairs(lsp.disable or {}) do
    for _, client in ipairs(vim.lsp.get_clients({ name = server })) do
      client:stop()
    end
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == server then client:stop() end
      end,
    })
  end

  local disable_fmt = lsp.disable_formatting or {}
  if #disable_fmt > 0 then
    local disabled_set = {}
    for _, name in ipairs(disable_fmt) do disabled_set[name] = true end
    local function strip_formatting(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and disabled_set[client.name] then strip_formatting(client) end
      end,
    })
    for _, client in ipairs(vim.lsp.get_clients()) do
      if disabled_set[client.name] then strip_formatting(client) end
    end
  end

  -- lsp.enable: for servers without a mason-lspconfig mapping (e.g. eslint)
  for _, server in ipairs(lsp.enable or {}) do
    local cfg = vim.lsp.config[server]
    if not (cfg and cfg.filetypes) then goto continue end
    local ft_set = {}
    for _, ft in ipairs(cfg.filetypes) do ft_set[ft] = true end
    vim.api.nvim_create_autocmd('FileType', {
      pattern  = cfg.filetypes,
      callback = function() vim.lsp.start(vim.lsp.config[server]) end,
    })
    if ft_set[vim.bo.filetype] then
      vim.lsp.start(cfg)
    end
    ::continue::
  end
end

local function mason_install(tools)
  pcall(require, "mason")
  local ok, registry = pcall(require, "mason-registry")
  if not ok then
    vim.notify("[project] mason-registry not available", vim.log.levels.WARN)
    return
  end

  local function install_all()
    for _, name in ipairs(tools) do
      local pkg_ok, pkg = pcall(registry.get_package, name)
      if not pkg_ok then
        vim.notify("[project] mason: unknown package '" .. name .. "'", vim.log.levels.WARN)
      elseif not pkg:is_installed() then
        vim.notify("[project] mason: installing " .. name, vim.log.levels.INFO)
        pkg:install()
      end
    end
  end

  registry.refresh(function(success)
    if not success then
      -- registry already cached — proceed anyway
    end
    vim.schedule(install_all)
  end)
end

local function apply_mason(project)
  local tools = project.mason_tools or {}
  if #tools == 0 then return end
  mason_install(tools)
end

local function apply_formatters(project)
  local overrides = project.formatters or {}
  local disabled = project.disable_formatters or {}
  if vim.tbl_isempty(overrides) and #disabled == 0 then return end
  local ok, conform = pcall(require, "conform")
  if not ok then return end
  if not vim.tbl_isempty(overrides) then
    conform.formatters_by_ft = vim.tbl_extend("force", conform.formatters_by_ft, overrides)
  end
  if #disabled > 0 then
    local disabled_set = {}
    for _, name in ipairs(disabled) do disabled_set[name] = true end
    for ft, formatters in pairs(conform.formatters_by_ft) do
      conform.formatters_by_ft[ft] = vim.tbl_filter(function(f)
        return not disabled_set[f]
      end, formatters)
    end
  end
end

local function apply_linters(project)
  local overrides = project.linters or {}
  if vim.tbl_isempty(overrides) then return end
  local ok, lint = pcall(require, "lint")
  if not ok then return end
  lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft, overrides)
end

-- ── called on VimEnter from plugins/init.lua ─────────────────────────────────

function M.apply()
  local project = vim.g.project or {}
  if vim.tbl_isempty(project) then return end

  apply_lsp(project)
  apply_mason(project)
  apply_formatters(project)
  apply_linters(project)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(ev)
      if ev.data == "conform.nvim" then apply_formatters(project) end
      if ev.data == "nvim-lint" then apply_linters(project) end
    end,
  })
end

return M
