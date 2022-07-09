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

  -- null_ls.builtins.completion.spell
  null_ls.setup({
    debug = false,
    sources = {
      -- Set a formatter
      -- rubocop_daemon,
      formatting.rubocop,
      -- Set a linter
      -- diagnostics.rubocop,
      -- Set formatter

      formatting.stylua,
      formatting.prettierd,
      formatting.pg_format,
      diagnostics.sqlfluff,
      code_actions.eslint_d,
      formatting.gofmt,
      -- completion.spell,
    },
    -- NOTE: You can remove this on attach function to disable format on save
    -- on_attach = function(client)
    --   if client.resolved_capabilities.document_formatting then
    --     -- vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    --   end
    -- end,
  })
end

return M
