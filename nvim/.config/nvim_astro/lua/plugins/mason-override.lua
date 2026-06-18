-- {
--     "mason-org/mason-lspconfig.nvim",
--     optional = true,
--     opts = function(_, opts)
--       opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "marksman" })
--     end,
--   },
--   {
--     "WhoIsSethDaniel/mason-tool-installer.nvim",
--     optional = true,
--     opts = function(_, opts)
--       opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "marksman" })
--     end,
--   },

return {
  {
    "mason-org/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "marksman" })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      -- potpuno zameni ensure_installed sa svojom listom
      -- default je lua-language-server, plus project.mason_tools ako postoji
      local default_tools = { "lua-language-server", "marksman" }

      if vim.g.project and vim.g.project.mason_tools then
        for _, tool in ipairs(vim.g.project.mason_tools) do
          table.insert(default_tools, tool)
        end
      end
      opts.ensure_installed = default_tools
    end,
  },
}
