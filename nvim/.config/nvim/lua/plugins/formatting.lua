return {
  -- ── conform (formatter) ───────────────────────────────────────────────────────
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufWritePre' },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua             = { 'stylua' },
          javascript      = { 'prettier' },
          typescript      = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescriptreact = { 'prettier' },
          json            = { 'prettier' },
          jsonc           = { 'prettier' },
          css             = { 'prettier' },
          html            = { 'prettier' },
          markdown        = { 'prettier' },
          yaml            = { 'prettier' },
          rust            = { 'rustfmt' },
        },
        format_on_save = function(_)
          local project = vim.g.project or {}
          if project.disable_format_on_save then return nil end
          return { timeout_ms = 1000, lsp_format = 'fallback' }
        end,
      })
    end,
  },

  -- ── nvim-lint ─────────────────────────────────────────────────────────────────
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufWritePost' },
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        ruby = { 'rubocop' },
      }
      lint.linters.rubocop = vim.tbl_extend('force', lint.linters.rubocop, {
        cmd = 'bundle',
        args = vim.list_extend({ 'exec', 'rubocop' }, lint.linters.rubocop.args or {}),
      })
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
        callback = function() lint.try_lint() end,
      })
    end,
  },
}
