return function(_, opts)
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  local h = require("null-ls.helpers")
  local methods = require("null-ls.methods")

  local FORMATTING = methods.internal.FORMATTING

  local rubocop_daemon = h.make_builtin({
    name = "rubocopd",
    meta = {
      url = "https://github.com/rubocop/rubocop",
      description = "Ruby static code analyzer and formatter, based on the community Ruby style guide.",
    },
    method = FORMATTING,
    filetypes = { "ruby" },
    generator_opts = {
      command = "rubocop-daemon",
      args = {
        -- NOTE: For backwards compatibility,
        -- we are still using "-a" shorthand' for both "--auto-correct" (pre-1.3.0) and "--autocorrect" (1.3.0+).
        "exec",
        "--",
        "--auto-correct",
        -- "--stderr",
        -- "--stdin",
        "$FILENAME",
      },
      to_stdin = true,
    },
    factory = h.formatter_factory,
  })

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

    -- formatting.rubocop,
    rubocop_daemon,
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
