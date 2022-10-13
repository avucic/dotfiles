local M = {}

M.config = function()
  local present, onedark = pcall(require, "onedark")
  if not present then
    return
  end

  onedark.setup()

  vim.cmd([[
   " hi CurrentWordTwins guibg=#3e4452 cterm=NONE
   hi CurrentWordTwins guibg=#21252b gui=none cterm=none
   hi DiagnosticHint guibg=#003C48 guifg=#009999
   hi DiagnosticSignHint guifg=#009999 guibg=NONE
   hi DiagnosticWarn guifg=#e5c07b  guibg=#573B02
   hi DiagnosticSignWarn  guifg=#B28D48 guibg=NONE
   hi DiagnosticVirtualTextInfo guibg=#003C48 guifg=#009999
   hi DiagnosticVirtualTextError guibg=#3E282F guifg=#e86671

   hi DashboardHeader guifg=#393f4a

   hi LspReferenceText guibg=NONE
   hi LspReferenceRead guibg=NONE

   hi NeoTreeNormal guibg=#24282f
   hi NeoTreeNormalNC guibg=#24282f
   hi NeoTreeTitleBar guibg=#61afef guifg=#20232A

   hi NeogitDiffContextHighlight guibg=#2c313a
   hi NeogitHunkHeaderHighlight guibg=#2c313a

   hi FocusedSymbol guibg=NONE guifg=#d19a66
   hi Folded guifg = #69707d  guibg=#2c313a

   hi MatchParen ctermbg=blue guibg=#2C303A cterm=NONE

   hi MarkdownHeaderMarker guifg=#d19a66
   hi MarkdownTableHeaderCell guifg=#d19a66 gui=italic

   " hi MarkdownTable guifg=#393f4a
   hi HydraHint guibg=#24282f
   hi FloatBorder guifg=#69707d
   hi STS_highlight guifg=#40E6EA
   hi h1 guifg=#40E6EA
  ]])
end

-- hi @punctuation.special guifg=#009999
return M
