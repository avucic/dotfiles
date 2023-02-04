return function(_, opts)
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  -- local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions.eslint

  -- config variable is the default configuration table for the setup functino call
  -- local null_ls = require "null-ls"

  -- Check supported formatters and linters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  opts.sources = {

    -- Set a formatter
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.prettier,

    formatting.rubocop,
    -- Set a linter
    -- diagnostics.rubocop,
    -- Set formatter

    formatting.stylua,
    formatting.prettierd.with({ extra_filetypes = { "html", "template", "json" } }),

    formatting.pg_format,

    -- sqlfluff_format,
    -- sqlfluff_diagnostic,
    -- formatting.sqlfluff,
    -- diagnostics.sqlfluff,

    -- diagnostics.checkmake,
    code_actions.eslint_d,
    formatting.gofmt,
    formatting.rustfmt.with({
      extra_args = { "--edition=2021" },
    }),
  }
  return opts
end
