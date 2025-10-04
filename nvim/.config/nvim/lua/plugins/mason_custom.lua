-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        "json-lsp",
        -- install language servers
        "lua-language-server",
        "herb-language-server",
        "ruby-lsp",

        -- install formatters
        "stylua",

        -- install debuggers
        -- "debugpy",

        -- install any other package
        "tree-sitter-cli",

        -- "erb_lint",
        -- "marksman",
        "zk",
        "css-lsp",
      },
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.handlers.prettierd = function()
        null_ls.register(null_ls.builtins.formatting.prettierd.with {
          filetypes = { "html" },
        })
      end
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = function(plugin, opts)
      opts.servers = opts.servers or {}
      vim.list_extend(opts.servers, {
        "herb_ls",
      })

      opts.custom_servers = require("astrocore").extend_tbl(opts.custom_servers or {}, {
        -- Define herb_ls as a custom server with its command and filetypes
        herb_ls = {
          cmd = { "herb-language-server", "--stdio" },
          filetypes = { "eruby", "erb", "html.erb" },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local configs = require "lspconfig.configs"
      local util = require "lspconfig.util"

      configs.herb_ls = {
        default_config = {
          cmd = { "herb-language-server", "--stdio" },
          filetypes = { "html", "eruby" },
          root_dir = util.root_pattern("Gemfile", ".git"),
        },
      }

      opts.servers = opts.servers or {}
      opts.servers.herb_ls = opts.servers.herb_ls or {}
    end,
  },
}
