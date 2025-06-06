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
}
