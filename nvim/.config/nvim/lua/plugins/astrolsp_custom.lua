-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
-- example
--
-- vim.g.project = {
--   astro_packs = {
--     "astrocommunity.pack.typescript",
--   },
--   mason_tools = {
--     "typescript-language-server",
--     "eslint-lsp",
--   },
--   lsp = {
--     -- servers where formatting should be disabled
--     -- disable_formatting = { "ts_ls" },
--
--     servers = {
--       ts_ls = {
--         on_attach = function(client, _bufnr)
--           client.server_capabilities.documentFormattingProvider = false
--           client.server_capabilities.documentRangeFormattingProvider = false
--         end,
--       },
--     },
--   },
--
--   -- disable specific none-ls/conform formatters in this project
--   disable_formatters = { "prettierd", "rubocop" },
-- }

return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    local project = vim.g.project or {}
    local lsp_cfg = project.lsp or {}

    -- Disable formatting capability for specific servers
    opts.formatting = opts.formatting or {}
    opts.formatting.disabled = opts.formatting.disabled or {}

    for _, server in ipairs(lsp_cfg.disable_formatting or {}) do
      table.insert(opts.formatting.disabled, server)
    end

    for server, server_opts in pairs(lsp_cfg.servers or {}) do
      local existing = opts.config[server] or {}

      local prev_on_attach = existing.on_attach
      local user_on_attach = server_opts.on_attach
      server_opts.on_attach = nil

      opts.config[server] = vim.tbl_deep_extend("force", existing, server_opts)

      if prev_on_attach or user_on_attach then
        opts.config[server].on_attach = function(client, bufnr)
          if prev_on_attach then prev_on_attach(client, bufnr) end
          if user_on_attach then user_on_attach(client, bufnr) end
        end
      end
    end
    --
    -- Merge per-server config overrides
    opts.config = opts.config or {}
    for server, server_opts in pairs(lsp_cfg.servers or {}) do
      opts.config[server] = vim.tbl_deep_extend("force", opts.config[server] or {}, server_opts)
    end

    return opts
  end,
}
