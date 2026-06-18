local project = require('utils.project')

return {
  cmd       = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_dir = function(fname)
    return project.eslint_root() or vim.fs.root(fname, { 'eslint.config.js', '.eslintrc.js', 'package.json', '.git' })
  end,
  settings = {
    workingDirectories = { mode = 'auto' },
    experimental = { useFlatConfig = true },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })
  end,
}
