return {
  cmd      = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_dir = function(fname)
    return vim.fs.root(fname, { 'Gemfile', '.ruby-version', '.git' })
      or vim.fn.fnamemodify(fname, ':h')
  end,
  init_options = {
    formatter = 'auto',
    linters = { 'rubocop' },
    enabledFeatures = {
      codeActions = true,
      codeLens = true,
      completion = true,
      definition = true,
      diagnostics = true,
      documentHighlights = true,
      documentLink = true,
      documentSymbols = true,
      foldingRanges = true,
      formatting = true,
      hover = true,
      inlayHint = true,
      onTypeFormatting = true,
      references = true,
      rename = true,
      selectionRanges = true,
      semanticHighlighting = true,
      signatureHelp = true,
      typeHierarchy = true,
      workspaceSymbol = true,
    },
  },
}
