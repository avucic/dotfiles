-- https://blog.codeminer42.com/configuring-language-server-protocol-in-neovim/
-- local conditional = function(fn)
--   local utils = require("null-ls.utils").make_conditional_utils()
--   return fn(utils)
-- end

-- Here we set a conditional to call the rubocop formatter. If we have a Gemfile in the project, we call "bundle exec rubocop", if not we only call "rubocop".
-- conditional(function(utils)
--     return utils.root_has_file("Gemfile")
--         and null_ls.builtins.formatting.rubocop.with({
--         command = "bundle",
--         args = vim.list_extend(
--           { "exec", "rubocop" },
--           null_ls.builtins.formatting.rubocop._opts.args
--         ),
--     })
--     or null_ls.builtins.formatting.rubocop
-- end)
--
-- -- Same as above, but with diagnostics.rubocop to make sure we use the proper rubocop version for the project
-- conditional(function(utils)
--     return utils.root_has_file("Gemfile")
--             and null_ls.builtins.diagnostics.rubocop.with({
--             command = "bundle",
--             args = vim.list_extend(
--               { "exec", "rubocop" },
--               null_ls.builtins.diagnostics.rubocop._opts.args
--             ),
--         })
--         or null_ls.builtins.diagnostics.rubocop
--     end),
-- },

return function(_, opts)
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions.eslint
  local bundle_gemfile = os.getenv("BUNDLE_GEMFILE") or "~/.config/nvim/Gemfile"

  -- config variable is the default configuration table for the setup functino call
  -- local null_ls = require "null-ls"

  -- Check supported formatters and linters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  -- opts.debug = true
  opts.sources = {

    -- Set a formatter
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.prettier,

    -- formatting.rubocop,
    -- rubocop_with_server,
    -- rubocop_daemon,
    -- Set a linter
    -- diagnostics.rubocop,
    -- Set formatter

    formatting.stylua,
    formatting.erb_format.with({
      command = "bundle",
      args = {
        "exec",
        "erb-format",
        "--stdin",
      },
      env = {
        BUNDLE_GEMFILE = bundle_gemfile,
      },
    }),

    diagnostics.erb_lint.with({
      command = "bundle",
      args = {
        "exec",
        "erblint",
        "--format",
        "json",
        "--stdin",
        "$FILENAME",
      },
      env = {
        BUNDLE_GEMFILE = bundle_gemfile,
      },
    }),

    formatting.prettierd.with({ extra_filetypes = { "html", "template", "json", "yaml" } }),
    formatting.pg_format,

    -- sqlfluff_format,
    -- sqlfluff_diagnostic,
    -- formatting.sqlfluff,
    -- diagnostics.sqlfluff,

    -- diagnostics.checkmake,
    code_actions.eslint_d,
    formatting.gofmt,
    formatting.beautysh,
    formatting.beautysh.with({
      command = "beautysh",
      args = {
        "--indent-size 2",
        "$FILENAME",
      },
    }),
    formatting.rustfmt.with({
      extra_args = { "--edition=2021" },
    }),
  }
  return opts
end
