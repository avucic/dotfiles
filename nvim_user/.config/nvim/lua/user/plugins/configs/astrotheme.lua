--   none = "NONE",
--   red = "#e06c75",
--   blue = "#61afef",
--   green = "#98c379",
--   yellow = "#e5c06b",
--   purple = "#c678dd",
--   cyan = "#56b6c2",
--   orange = "#d19a66",
--   dark_red = "#ec5f67",
--   light_blue = "#90c7f3",
--   light_green = "#89b06d",
--   dark_yellow = "#ebae34",
--   light_purple = "#a9a1e1",
--   light_cyan = "#88cbd4",
--   dark_orange = "#ff9640",
--   text = "#abb2bf",
--   subtext1 = "#777d86",
--   subtext0 = "#4b5263",
--   overlay2 = "#282c34",
--   overlay1 = "#2c323c",
--   overlay0 = "#c9c9c9",
--   surface2 = "#dedede",
--   surface1 = "#3e4452",
--   surface0 = "#252931",
--   base = "#1e222a",
--   mantle = "#181a1f",
--   crust = "#1f1f25",
--   -- icon colors
--   c = "#519aba",
--   css = "#61afef",
--   deb = "#a1b7ee",
--   docker = "#384d54",
--   html = "#de8c92",
--   jpeg = "#c882e7",
--   jpg = "#c882e7",
--   js = "#ebcb8b",
--   jsx = "#519ab8",
--   kt = "#7bc99c",
--   lock = "#c4c720",
--   lua = "#51a0cf",
--   mp3 = "#d39ede",
--   mp4 = "#9ea3de",
--   out = "#abb2bf",
--   png = "#c882e7",
--   py = "#a3b8ef",
--   rb = "#ff75a0",
--   robots = "#abb2bf",
--   rpm = "#fca2aa",
--   rs = "#dea584",
--   toml = "#39bf39",
--   ts = "#519aba",
--   ttf = "#abb2bf",
--   vue = "#7bc99c",
--   woff = "#abb2bf",
--   woff2 = "#abb2bf",
--   zip = "#f9d71c",
--   md = "#519aba",
--   pkg = "#d39ede",

return function(_, opts)
  return {
    termguicolors = true,    -- Bool value, toggles if termguicolors are set by AstroTheme.
    terminal_color = true,   -- Bool value, toggles if terminal_colors are set by AstroTheme.
    plugin_default = "auto", -- Sets how all plugins will be loaded
    -- "auto": Uses lazy / packer enabled plugins to load highlights.
    -- true: Enables all plugins highlights.
    -- false: Disables all plugins.

    plugins = { -- Allows for individual plugin overides using plugin name and value from above.
      ["bufferline.nvim"] = true,
    },
    palettes = {
      global = {
        -- Globaly accessible palettes, theme palettes take priority.
        -- my_grey = "#ebebeb",
        -- my_color = "#ffffff"
        float_color = "#1a1d24",
      },
      astrodark = {
        -- Extend or modify astrodarks palette colors
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
          -- hl.WinSeparator = { fg = C.overlay1, bg = C.black }
          -- hl.WinSeparatorNC = { fg = C.overlay1, bg = C.red }
          --
          -- -- New approach instead of diagnostic_style
          hl.DiagnosticError.italic = true
          hl.DiagnosticHint.italic = true
          hl.DiagnosticInfo.italic = true
          hl.DiagnosticWarn.italic = true
          hl.TelescopePromptTitle = { fg = C.bg, bg = C.cyan }
          hl.TelescopePromptBorder = { fg = C.overlay1, bg = C.overlay1 }
          hl.TelescopePromptNormal = { fg = C.fg, bg = C.overlay1 }
          hl.TelescopePreviewTitle = { fg = C.bg, bg = C.green }
          hl.TelescopePreviewBorder = { fg = C.bg, bg = C.bg }
          hl.TelescopeResultsTitle = { fg = C.bg, bg = C.yellow }
          hl.TelescopeResultsBorder = { fg = C.bg, bg = C.bg }
          hl.DashboardHeader = { fg = C.overlay1 }
          hl.DashboardTasks = { fg = C.purple }
          hl.DashboardFooter = { fg = C.overlay1 }
          hl.TelescopeResultsDiffChange = { bg = C.NONE, fg = C.yellow }
          hl.TelescopeResultsDiffDelete = { bg = C.NONE, fg = C.red }
          hl.TelescopeResultsDiffAdd = { bg = C.NONE, fg = C.green }
          hl.TelescopeResultsDiffUntracked = { bg = C.NONE, fg = C.subtext1 }

          -- -- hl.BufferLineBufferVisible = { fg = C.bg }
          --
          hl.FloatBorder = { fg = C.subtext0 }
          hl.NormalFloat = { bg = C.float_color, fg = C.subtext0 }
          hl.FloatTitle = { fg = C.subtext0 }
          --
          hl.DailyNote = { fg = C.yellow }
          hl.ReferenceNote = { fg = C.blue }
          hl.SlipNote = { fg = C.green }
          hl.JournalNote = { fg = C.light_purple }
          hl.ProjectNote = { fg = C.cyan }
          --
          hl["@text.strong"] = { fg = C.fg, bold = true }
          hl["@text.emphasis"] = { fg = C.fg, italic = true }

          hl["@h1"] = { fg = C.dark_orange }
          hl["@MarkdownHeaderMarkerH1"] = { fg = C.dark_orange }

          hl["@h2"] = { fg = C.purple }
          hl["@MarkdownHeaderMarkerH2"] = { fg = C.purple }

          hl["@h3"] = { fg = C.light_purple }
          hl["@MarkdownHeaderMarkerH3"] = { fg = C.light_purple }

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
          hl["@MarkdownHorizontalLine"] = { fg = C.red, bg = C.overlay1 }

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
