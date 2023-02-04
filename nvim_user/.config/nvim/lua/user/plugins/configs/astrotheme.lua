return function(_, opts)
  return {
    termguicolors = true, -- Bool value, toggles if termguicolors are set by AstroTheme.

    terminal_color = true, -- Bool value, toggles if terminal_colors are set by AstroTheme.

    plugin_default = "auto", -- Sets how all plugins will be loaded
    -- "auto": Uses lazy / packer enabled plugins to load highlights.
    -- true: Enables all plugins highlights.
    -- false: Disables all plugins.

    plugins = { -- Allows for individual plugin overides using plugin name and value from above.
      ["bufferline.nvim"] = true,
    },

    palettes = {
      global = { -- Globaly accessible palettes, theme palettes take priority.
        -- my_grey = "#ebebeb",
        -- my_color = "#ffffff"
        float_color = "#1a1d24",
      },
      astrodark = { -- Extend or modify astrodarks palette colors
        -- red = "#800010", -- Overrides astrodarks red color
        -- my_color = "#000000", -- Overrides global.my_color
        fg = "#abb2bf",
        bg = "#1e222a",
      },
    },

    highlights = {
      global = { -- Add or modify hl groups globaly, theme specific hl groups take priority.
        -- modify_hl_groups = function(hl, c)
        -- end,
        -- ["@String"] = { fg = "#ff6600", bg = "NONE" }
      },
      astrodark = {
        -- first parameter is the highlight table and the second parameter is the color palette table
        modify_hl_groups = function(hl, C) -- modify_hl_groups function allows you to modify hl groups,
          -- hl.Comment.fg = c.my_color
          -- hl.Comment.italic = true
          -- local float_color = "#1a1d24"

          hl.Comment.italic = true
          hl.Normal = { fg = C.fg, bg = C.bg }
          --
          -- hl.WinSeparator = { fg = C.bg_1, bg = C.black }
          -- hl.WinSeparatorNC = { fg = C.bg_1, bg = C.red }
          --
          -- -- New approach instead of diagnostic_style
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
          hl.TelescopeResultsDiffChange = { bg = C.NONE, fg = C.yellow }
          hl.TelescopeResultsDiffDelete = { bg = C.NONE, fg = C.red }
          hl.TelescopeResultsDiffAdd = { bg = C.NONE, fg = C.green }
          hl.TelescopeResultsDiffUntracked = { bg = C.NONE, fg = C.grey_2 }
          -- -- hl.BufferLineBufferVisible = { fg = C.bg }
          --
          hl.FloatBorder = { fg = C.grey_2 }
          hl.NormalFloat = { bg = C.float_color, fg = C.grey_2 }
          hl.FloatTitle = { fg = C.grey_2 }
          --
          hl.DailyNote = { fg = C.yellow_2 }
          hl.ReferenceNote = { fg = C.blue }
          hl.SlipNote = { fg = C.green }
          hl.JournalNote = { fg = C.purple_1 }
          hl.ProjectNote = { fg = C.cyan }
          --
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
        end,
      },
    },
  }
end
