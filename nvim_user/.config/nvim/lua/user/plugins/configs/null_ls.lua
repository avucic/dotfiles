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

  -- local h = require("null-ls.helpers")
  -- local methods = require("null-ls.methods")
  --
  -- local FORMATTING = methods.internal.D

  -- local rubocop_with_server = h.make_builtin({
  --   name = "rubocop",
  --   meta = {
  --     url = "https://github.com/rubocop/rubocop",
  --     description = "Ruby static code analyzer and formatter, based on the community Ruby style guide.",
  --   },
  --   method = FORMATTING,
  --   filetypes = { "ruby" },
  --   generator_opts = {
  --     command = "rubocop",
  --     args = {
  --       "--server",
  --       "-a",
  --       "-f",
  --       "quiet",
  --       "--stderr",
  --       "--stdin",
  --       "$FILENAME",
  --     },
  --     to_stdin = true,
  --   },
  --   factory = h.formatter_factory,
  -- })

  -- local rubocop_daemon = h.make_builtin({
  --   name = "rubocop-daemon",
  --   meta = {
  --     url = "https://github.com/rubocop/rubocop",
  --     description = "Ruby static code analyzer and formatter, based on the community Ruby style guide.",
  --   },
  --   method = FORMATTING,
  --   filetypes = { "ruby" },
  --   generator_opts = {
  --     -- command = "rubocopd",
  --     -- args = {
  --     --   "-a",
  --     --   "--parallel",
  --     --   "-f",
  --     --   "quiet",
  --     --   "--stderr",
  --     --   "--stdin",
  --     --   "$FILENAME",
  --     -- },
  --     -- to_stdin = true,
  --     command = "rubocopd",
  --     args = {
  --       "-a",
  --       -- "--server",
  --       "-f",
  --       "quiet",
  --       "--stderr",
  --       "--stdin",
  --       "$FILENAME",
  --     },
  --     to_stdin = true,
  --     ignore_stderr = true,
  --     from_stderr = true,
  --   },
  --   factory = h.formatter_factory,
  -- })
  --
  -- config variable is the default configuration table for the setup functino call
  -- local null_ls = require "null-ls"

  -- Check supported formatters and linters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  opts.debug = true
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
    -- diagnostics.standardrb,
    formatting.prettierd.with({ extra_filetypes = { "html", "template", "json", "yaml" } }),

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
