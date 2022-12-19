local M = {}

M.config = function() -- or a function that returns a new table of colors to set
  return {
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl)
      local C = require("default_theme.colors")
      -- local float_color = "#1a1d24"

      hl.Comment.italic = true
      hl.Normal = { fg = C.fg, bg = C.bg }

      hl.WinSeparator = { fg = C.bg_1, bg = C.black }
      hl.WinSeparatorNC = { fg = C.bg_1, bg = C.red }

      -- New approach instead of diagnostic_style
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true
      hl.TelescopePromptTitle = { fg = C.bg, bg = C.cyan }
      hl.TelescopePromptBorder = { fg = C.bg_1, bg = C.bg_1 }
      hl.TelescopePromptNormal = { fg = C.fg, bg = C.bg_1 }
      hl.TelescopePreviewTitle = { fg = C.bg, bg = C.green }
      hl.TelescopePreviewBorder = { fg = C.bg, bg = C.bg }
      hl.TelescopeResultsTitle = { fg = C.bg, bg = C.yellow }
      hl.TelescopeResultsBorder = { fg = C.bg, bg = C.bg }
      hl.DashboardHeader = { fg = C.bg_1 }
      hl.DashboardTasks = { fg = C.purple }
      hl.DashboardFooter = { fg = C.bg_1 }

      hl.FloatBorder = { fg = C.grey_2 }
      -- hl.HydraBorder = { fg = float_color, bg = float_color }
      -- hl.NormalFloat = { bg = float_color }

      hl["@text.strong"] = { fg = C.fg, bold = true }
      hl["@text.emphasis"] = { fg = C.fg, italic = true }

      hl["@h1"] = { fg = C.orange_1 }
      hl["@MarkdownHeaderMarkerH1"] = { fg = C.orange_1 }

      hl["@h2"] = { fg = C.purple }
      hl["@MarkdownHeaderMarkerH2"] = { fg = C.purple }

      hl["@h3"] = { fg = C.purple_1 }
      hl["@MarkdownHeaderMarkerH3"] = { fg = C.purple_1 }

      hl["@h4"] = { fg = C.cyan }
      hl["@MarkdownHeaderMarkerH4"] = { fg = C.cyan }

      hl["@h5"] = { fg = C.yellow }
      hl["@MarkdownHeaderMarkerH5"] = { fg = C.yellow }

      hl["@h6"] = { fg = C.orange }
      hl["@MarkdownHeaderMarkerH6"] = { fg = C.orange }

      hl["@text.reference"] = { fg = C.blue }
      hl["@text.emphasis"].fg = C.white
      hl["@text.strong"].fg = C.white
      hl["@punctuation.delimiter"] = { fg = C.yellow }

      hl["@MarkdownBlockQuote"] = { fg = C.blue_3, italic = true }
      hl["@MarkdownMeta"] = { link = "Comment" }
      hl["@MarkdownInlineBlockCode"] = { fg = C.green, bg = C.black }
      hl["@MarkdownCodeBlockBG"] = { bg = C.black }
      hl["@MarkdownTableHeaderCell"] = { link = "BufferInactiveMod" }
      hl["@MarkdownTable"] = { link = "BufferVisibleTarget" }
      hl["@MarkdownListItemMarker"] = { link = "@comment" }
      hl["@MarkdownTag"] = { link = "@constant" }
      hl["@MarkdownTagItem"] = { link = "@constant" }
      hl["@MarkdownHorizontalLine"] = { fg = C.red, bg = C.bg_1 }

      hl["SpellBad"] = { sp = "red", undercurl = true }
      hl["SpellCap"] = { sp = "yellow", undercurl = true }
      hl["SpellRare"] = { sp = "blue", undercurl = true }
      hl["SpellLocal"] = { sp = "red", undercurl = true }
      hl["@text.note"] = { link = "@constant" }

      hl["STS_highlight"] = { fg = "#00F1F5" }

      -- vim.cmd([[
      --   hi SpellBad   guifg=NONE guisp=red    gui=undercurl term=underline cterm=undercurl
      --   hi SpellCap   guifg=NONE guisp=yellow gui=undercurl term=underline cterm=undercurl
      --   hi SpellRare  guifg=NONE guisp=blue   gui=undercurl term=underline cterm=undercurl
      --   hi SpellLocal guifg=NONE guisp=red gui=undercurl term=underline cterm=undercurl
      --     ]])
      --
      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  }
end

return M
