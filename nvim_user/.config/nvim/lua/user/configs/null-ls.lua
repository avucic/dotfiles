local M = {}
function M.config()
  -- Formatting and linting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim

  local h = require("user.core.utils").load_module("null-ls.helpers")
  if not h then
    return {}
  end

  local methods = require("user.core.utils").load_module("null-ls.methods")
  if not methods then
    return {}
  end

  local null_ls = require("user.core.utils").load_module("null-ls")
  if not null_ls then
    return {}
  end

  -- local FORMATTING = methods.internal.FORMATTING

  -- local rubocop_daemon = h.make_builtin({
  --   name = "rubocop_daemon",
  --   meta = {
  --     url = "https://github.com/rubocop/rubocop",
  --     description = "Ruby static code analyzer and formatter, based on the community Ruby style guide.",
  --   },
  --   method = FORMATTING,
  --   filetypes = { "ruby" },
  --   generator_opts = {
  --     command = "rubocop-daemon",
  --     args = {
  --       "exec",
  --       "--",
  --       "--auto-correct-all",
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
  --   name = "rubocop",
  --   meta = {
  --     url = "https://github.com/rubocop/rubocop",
  --     description = "Ruby static code analyzer and formatter, based on the community Ruby style guide.",
  --   },
  --   method = FORMATTING,
  --   filetypes = { "ruby" },
  --   generator_opts = {
  --     command = "rubocop-daemon",
  --     args = {
  --       "exec",
  --       "--",
  --       "--autocorrect",
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
  --
  -- Check supported formatters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions.eslint
  -- local completion = null_ls.builtins.completion

  -- Check supported linters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  -- local diagnostics = null_ls.builtins.diagnostics
  local sqlfluff_format = null_ls.builtins.formatting.sqlfluff.with({
    -- args = { "fix", "--dialect", "postgres", "--disable_progress_bar", "-f", "-n", "-" },
    extra_args = { "--dialect", "postgres", "--config", "/Users/vucinjo/.sqlfluff" },
  })

  local sqlfluff_diagnostic = null_ls.builtins.diagnostics.sqlfluff.with({
    -- args = { "lint", "--dialect", "postgres", "-f", "github-annotation", "-n", "--disable_progress_bar", "-" },
    extra_args = { "--dialect", "postgres", "--config", "/Users/vucinjo/.sqlfluff" },
  })

  return function(config) -- overrides `require("null-ls").setup(config)`
    -- config variable is the default configuration table for the setup functino call
    -- local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,

      formatting.rubocop,
      -- Set a linter
      -- diagnostics.rubocop,
      -- Set formatter

      formatting.stylua,
      formatting.prettierd.with({ extra_filetypes = { "html", "template" } }),

      formatting.pg_format,

      -- sqlfluff_format,
      -- sqlfluff_diagnostic,
      -- formatting.sqlfluff,
      -- diagnostics.sqlfluff,

      diagnostics.checkmake,
      code_actions.eslint_d,
      formatting.gofmt,
    }
    -- set up null-ls's on_attach function
    -- NOTE: You can uncomment this on attach function to enable format on save
    -- config.on_attach = function(client)
    --   if client.resolved_capabilities.document_formatting then
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --       desc = "Auto format before save",
    --       pattern = "<buffer>",
    --       callback = vim.lsp.buf.formatting_sync,
    --     })
    --   end
    -- end
    return config -- return final config table to use in require("null-ls").setup(config)
  end
end

return M
