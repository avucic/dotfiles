return {
  {
    "williamboman/mason.nvim",
    -- opts = {
    --   PATH = "append",
    -- },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- "lua_ls",
        "solargraph",
        -- "ruby_ls",
        "emmet_ls",
        -- "gopls",
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
        "tailwindcss",
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
        "erb_lint",
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
    event = "User AstroFile",
  },
}
