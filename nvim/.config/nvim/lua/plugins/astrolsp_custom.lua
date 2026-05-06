-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

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

    -- Merge per-server config overrides
    opts.config = opts.config or {}
    for server, server_opts in pairs(lsp_cfg.servers or {}) do
      opts.config[server] = vim.tbl_deep_extend("force", opts.config[server] or {}, server_opts)
    end

    return opts
  end,
}
