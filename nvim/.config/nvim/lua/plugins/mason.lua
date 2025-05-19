if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    config = function()
      local lspconfig = require "lspconfig"

      lspconfig.your_language_server.setup {
        cmd = { "https://github.com/zk-org/zk/releases/download/v0.15.0/zk-v0.15.0-macos_arm64.tar.gz" },
        -- other configurations
      }
    end,
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- install formatters
        "stylua",

        -- install debuggers
        -- "debugpy",

        -- install any other package
        "tree-sitter-cli",

        -- "erb_lint",
        -- "marksman",
        "zk",
      },
    },
  },
}
