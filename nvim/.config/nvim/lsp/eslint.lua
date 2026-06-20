return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'javascript', 'javascriptreact', 'javascript.jsx',
    'typescript', 'typescriptreact', 'typescript.tsx',
  },
  root_dir = function(fname)
    return vim.fs.root(fname, {
      'eslint.config.js', 'eslint.config.mjs', 'eslint.config.cjs',
      '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', '.eslintrc.yaml', '.eslintrc.yml',
    })
  end,
  settings = {
    validate = 'on',
    packageManager = nil,
    useESLintClass = false,
    experimental = { useFlatConfig = nil },
    codeActionOnSave = { enable = false, mode = 'all' },
    format = { enable = false },
    quiet = false,
    onIgnoredFiles = 'off',
    rulesCustomizations = {},
    run = 'onType',
    problems = { shortenToSingleLine = false },
    nodePath = '',
    workingDirectory = { mode = 'auto' },
    codeAction = {
      disableRuleComment = { enable = true, location = 'separateLine' },
      showDocumentation = { enable = true },
    },
  },
  handlers = {
    ['eslint/openDoc'] = function(_, result)
      if result then vim.ui.open(result.url) end
      return {}
    end,
    ['eslint/confirmESLintExecution'] = function()
      return 4
    end,
    ['eslint/probeFailed'] = function()
      vim.notify('[eslint] probe failed', vim.log.levels.WARN)
      return {}
    end,
    ['eslint/noLibrary'] = function()
      vim.notify('[eslint] no ESLint library found', vim.log.levels.WARN)
      return {}
    end,
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'EslintFixAll', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { 'source.fixAll.eslint' }, diagnostics = {} },
      })
    end, {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.code_action({
          apply = true,
          context = { only = { 'source.fixAll.eslint' }, diagnostics = {} },
        })
      end,
    })
  end,
}
