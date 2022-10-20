local M = {}
local theme_style = "dark"

M.config = function()
  local present, onedark = pcall(require, "onedark")
  if not present then
    return
  end

  onedark.setup({ style = theme_style })
  onedark.load()

  -- TODO: remove this once treesitter and ondedark theme are fixed
  local hl = function(group, opts)
    opts.default = true
    vim.api.nvim_set_hl(0, group, opts)
  end

  local palette = require("onedark.palette")[theme_style]

  hl("@MarkdownBlockQuote", { link = "CmpItemAbbrDeprecated" })
  hl("@MarkdownMeta", { link = "@comment" })

  hl("@h1", { link = "@label" })
  hl("@MarkdownHeaderMarkerH1", { link = "@label" })

  hl("@h2", { link = "Conditional" })
  hl("@MarkdownHeaderMarkerH2", { link = "Conditional" })

  hl("@h3", { link = "@constant" })
  hl("@MarkdownHeaderMarkerH3", { link = "@constant" })

  hl("@h4", { link = "@attribute" })
  hl("@MarkdownHeaderMarkerH4", { link = "@attribute" })

  hl("@h5", { link = "@function" })
  hl("@MarkdownHeaderMarkerH5", { link = "@function" })

  hl("@h6", { link = "@namespace" })
  hl("@MarkdownHeaderMarkerH6", { link = "@namespace" })

  hl("@MarkdownTableHeaderCell", { link = "BufferInactiveMod" })
  hl("@MarkdownTable", { link = "BufferVisibleTarget" })
  hl("@MarkdownListItemMarker", { link = "@comment" })

  -- vim.cmd("hi clear MarkdownTableHeaderCell")
  -- vim.cmd("hi MarkdownBlockQuote guifg=#ff6600")
  -- vim.cmd([[hi MarkdownBlockQuote cterm=bold,italic gui=bold,italic guifg=#80858f guibg=#282c34 ]])
  -- vim.cmd("hi MarkdownTableHeaderCell cterm=italic gui=italic guifg=" .. palette.orange)
  vim.cmd("hi SpellBad guifg=NONE gui=undercurl guisp=" .. palette.dark_red)
  vim.cmd("hi CmpItemAbbrDeprecated cterm=italic gui=italic")
  vim.cmd("hi DashboardHeader guifg=" .. palette.bg2)
  vim.cmd("hi CurrentWordTwins guibg=" .. palette.bg2 .. " gui=none cterm=none")
  vim.cmd("hi FocusedSymbol guibg=NONE guifg=" .. palette.orange)
  vim.cmd("hi Folded guifg = " .. palette.grey .. "  guibg=" .. palette.bg0)
  vim.cmd("hi MatchParen guifg=" .. palette.bg_blue .. " guibg=NONE")

  -- black = "#181a1f",
  -- bg0 = "#282c34",
  -- bg1 = "#31353f",
  -- bg2 = "#393f4a",
  -- bg3 = "#3b3f4c",
  -- bg_d = "#21252b",
  -- bg_blue = "#73b8f1",
  -- bg_yellow = "#ebd09c",
  -- fg = "#abb2bf",
  -- purple = "#c678dd",
  -- green = "#98c379",
  -- orange = "#d19a66",
  -- blue = "#61afef",
  -- yellow = "#e5c07b",
  -- cyan = "#56b6c2",
  -- red = "#e86671",
  -- grey = "#5c6370",
  -- light_grey = "#848b98",
  -- dark_cyan = "#2b6f77",
  -- dark_red = "#993939",
  -- dark_yellow = "#93691d",
  -- dark_purple = "#8a3fa0",
  -- diff_add = "#31392b",
  -- diff_delete = "#382b2c",
  -- diff_change = "#1c3448",
  -- diff_text = "#2c5372",
  --
  -- -- Misc {{{
  -- hl("@comment", { link = "Comment" })
  -- -- hl('@error', {link = 'Error'})
  -- hl("@none", { bg = "NONE", fg = "NONE" })
  -- hl("@preproc", { link = "PreProc" })
  -- hl("@define", { link = "Define" })
  -- hl("@operator", { link = "Operator" })
  -- -- }}}
  --
  -- -- Punctuation {{{
  -- hl("@punctuation.delimiter", { link = "Delimiter" })
  -- hl("@punctuation.bracket", { link = "Delimiter" })
  -- hl("@punctuation.special", { link = "Delimiter" })
  -- -- }}}
  --
  -- -- Literals {{{
  -- hl("@string", { link = "String" })
  -- hl("@string.regex", { link = "String" })
  -- hl("@string.escape", { link = "SpecialChar" })
  -- hl("@string.special", { link = "SpecialChar" })
  --
  -- hl("@character", { link = "Character" })
  -- hl("@character.special", { link = "SpecialChar" })
  --
  -- hl("@boolean", { link = "Boolean" })
  -- hl("@number", { link = "Number" })
  -- hl("@float", { link = "Float" })
  -- -- }}}
  --
  -- -- Functions {{{
  -- hl("@function", { link = "Function" })
  -- hl("@function.call", { link = "Function" })
  -- hl("@function.builtin", { link = "Special" })
  -- hl("@function.macro", { link = "Macro" })
  --
  -- hl("@method", { link = "Function" })
  -- hl("@method.call", { link = "Function" })
  --
  -- hl("@constructor", { link = "Special" })
  -- hl("@parameter", { link = "Identifier" })
  -- -- }}}
  --
  -- -- Keywords {{{
  -- hl("@keyword", { link = "Keyword" })
  -- hl("@keyword.function", { link = "Keyword" })
  -- hl("@keyword.operator", { link = "Keyword" })
  -- hl("@keyword.return", { link = "Keyword" })
  --
  -- hl("@conditional", { link = "Conditional" })
  -- hl("@repeat", { link = "Repeat" })
  -- hl("@debug", { link = "Debug" })
  -- hl("@label", { link = "Label" })
  -- hl("@include", { link = "Include" })
  -- hl("@exception", { link = "Exception" })
  -- -- }}}
  --
  -- -- Types {{{
  -- hl("@type", { link = "Type" })
  -- hl("@type.builtin", { link = "Type" })
  -- hl("@type.qualifier", { link = "Type" })
  -- hl("@type.definition", { link = "Typedef" })
  --
  -- hl("@storageclass", { link = "StorageClass" })
  -- hl("@attribute", { link = "PreProc" })
  -- hl("@field", { link = "Identifier" })
  -- hl("@property", { link = "Function" })
  -- -- }}}
  --
  -- -- Identifiers {{{
  -- hl("@variable", { link = "Normal" })
  -- hl("@variable.builtin", { link = "Special" })
  --
  -- hl("@constant", { link = "Constant" })
  -- hl("@constant.builtin", { link = "Special" })
  -- hl("@constant.macro", { link = "Define" })
  --
  -- hl("@namespace", { link = "Include" })
  -- hl("@symbol", { link = "Identifier" })
  -- -- }}}
  --
  -- -- Text {{{
  -- hl("@text", { link = "Normal" })
  -- hl("@text.strong", { bold = true })
  -- hl("@text.emphasis", { italic = true })
  -- hl("@text.underline", { underline = true })
  -- hl("@text.strike", { strikethrough = true })
  -- hl("@text.title", { link = "Title" })
  -- hl("@text.literal", { link = "String" })
  -- hl("@text.uri", { link = "Underlined" })
  -- hl("@text.math", { link = "Special" })
  -- hl("@text.environment", { link = "Macro" })
  -- hl("@text.environment.name", { link = "Type" })
  -- hl("@text.reference", { link = "Constant" })
  --
  -- hl("@text.todo", { link = "Todo" })
  -- hl("@text.note", { link = "SpecialComment" })
  -- hl("@text.warning", { link = "WarningMsg" })
  -- hl("@text.danger", { link = "ErrorMsg" })
  -- -- }}}
  --
  -- -- Tags {{{
  -- hl("@tag", { link = "Tag" })
  -- hl("@tag.attribute", { link = "Identifier" })
  -- hl("@tag.delimiter", { link = "Delimiter" })
  -- -- }}}
  -- -- hl("@h1", { link = "SpecialComment" })
  -- -- hl("@h2", { link = "SpecialComment" })
  --
  -- vim.cmd([[
  --  " hi CurrentWordTwins guibg=#3e4452 cterm=NONE
  --  hi CurrentWordTwins guibg=#21252b gui=none cterm=none
  --  hi DiagnosticHint guibg=#003C48 guifg=#009999
  --  hi DiagnosticSignHint guifg=#009999 guibg=NONE
  --  hi DiagnosticWarn guifg=#e5c07b  guibg=#573B02
  --  hi DiagnosticSignWarn  guifg=#B28D48 guibg=NONE
  --  hi DiagnosticVirtualTextInfo guibg=#003C48 guifg=#009999
  --  hi DiagnosticVirtualTextError guibg=#3E282F guifg=#e86671
  --
  --  hi DashboardHeader guifg=#393f4a
  --
  --  hi LspReferenceText guibg=NONE
  --  hi LspReferenceRead guibg=NONE
  --
  --  hi NeoTreeNormal guibg=#24282f
  --  hi NeoTreeNormalNC guibg=#24282f
  --  hi NeoTreeTitleBar guibg=#61afef guifg=#20232A
  --
  --  hi NeogitDiffContextHighlight guibg=#2c313a
  --  hi NeogitHunkHeaderHighlight guibg=#2c313a
  --
  --  hi FocusedSymbol guibg=NONE guifg=#d19a66
  --  hi Folded guifg = #69707d  guibg=#2c313a
  --
  --  hi MatchParen ctermbg=blue guibg=#2C303A cterm=NONE
  --
  --  hi MarkdownHeaderMarker guifg=#d19a66
  --  hi MarkdownTableHeaderCell guifg=#d19a66 gui=italic
  --
  --  " hi MarkdownTable guifg=#393f4a
  --  hi HydraHint guibg=#24282f
  --  hi FloatBorder guifg=#69707d
  --  hi STS_highlight guifg=#40E6EA
  --  " hi h1 guifg=red
  --  " hi h2 guifg=#40E6EA
  --  " hi h3 guifg=#40E6EA
  --  " hi h4 guifg=#40E6EA
  --  " hi h5 guifg=#40E6EA
  --  " hi h6 guifg=#40E6EA
  -- ]])
end

-- hi @punctuation.special guifg=#009999
return M
