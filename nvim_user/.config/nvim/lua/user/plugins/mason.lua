return {
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "append",
      ui = {
        check_outdated_packages_on_open = false,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "solargraph",
        -- "standardrb",
        "gopls",
        "tsserver",
        "html",
        "cssls",
        "yamlls",
        "jsonls",
        "sqlls",
        "eslint",
        "vimls",
        "marksman",
        "zk",
        "svelte",
        "zls",
        "taplo",
        -- "grammarly"
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "prettier",
        "stylua",
        "gopls",
        "marksman",
        "zk",
        "eslint",
        "rustfmt",
        "codelldb",
      },
    },
    config = require("user.plugins.configs.mason_null_ls"),
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = require("user.plugins.configs.null_ls"),
  },
}
