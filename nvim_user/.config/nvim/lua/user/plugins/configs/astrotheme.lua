-- --------------------------------
-- --- Syntax
-- --------------------------------
-- c.syntax.red = "#FE8A90"
-- c.syntax.blue = "#63B7FC"
-- c.syntax.green = "#89BF63"
-- c.syntax.yellow = "#E1AA41"
-- c.syntax.purple = "#DB98EE"
-- c.syntax.cyan = "#1BC5B9"
-- c.syntax.orange = "#FE915E"
-- c.syntax.text = "#ADB0BB"
-- c.syntax.comment = "#696C76"
-- c.syntax.mute = "#595C66"
--
-- --------------------------------
-- --- UI
-- --------------------------------
-- c.ui.red = "#F37880"
-- c.ui.blue = "#50A4E9"
-- c.ui.green = "#75AD47"
-- c.ui.yellow = "#D09214"
-- c.ui.purple = "#CC83E3"
-- c.ui.cyan = "#00B298"
-- c.ui.orange = "#EB8331"
--
-- c.ui.accent = "#EB8331"
--
-- c.ui.tabline = "#111317"
-- c.ui.winbar = "#797D87"
-- c.ui.tool = "#16181D"
-- c.ui.base = "#1A1D23"
-- c.ui.inactive_base = "#16181D"
-- c.ui.statusline = "#111317"
-- c.ui.split = "#111317"
-- c.ui.popup = "#16181D"
-- c.ui.float = "#16181D"
-- c.ui.title = c.ui.accent
-- c.ui.border = "#7A7C7E"
-- c.ui.current_line = "#1E222A"
-- c.ui.scrollbar = c.ui.accent
-- c.ui.selection = "#26343F"
-- c.ui.menu_selection = c.ui.accent
-- c.ui.highlight = "#1E222A"
-- c.ui.none_text = "#3A3E47"
-- c.ui.text = "#9B9FA9"
-- c.ui.text_active = "#ADB0BB"
-- c.ui.text_inactive = "#494D56"
-- c.ui.text_match = c.ui.accent
--
-- --------------------------------
-- --- terminal
-- --------------------------------
-- c.term.black = c.ui.tabline
-- c.term.bright_black = c.ui.base
--
-- c.term.red = c.syntax.red
-- c.term.bright_red = c.syntax.red
--
-- c.term.green = c.syntax.green
-- c.term.bright_green = c.syntax.green
--
-- c.term.yellow = c.syntax.yellow
-- c.term.bright_yellow = c.syntax.yellow
--
-- c.term.blue = c.syntax.blue
-- c.term.bright_blue = c.syntax.blue
--
-- c.term.purple = c.syntax.purple
-- c.term.bright_purple = c.syntax.purple
--
-- c.term.cyan = c.syntax.cyan
-- c.term.bright_cyan = c.syntax.cyan
--
-- c.term.white = c.ui.base
-- c.term.bright_white = c.ui.base
--
-- c.term.background = c.ui.base
-- c.term.foreground = c.ui.text
--
-- --------------------------------
-- --- Icons
-- --------------------------------
-- c.icon = {
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
-- }
--
-- return c

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
        black = "#000000",
        white = "#ffffff",
        bright_white = "#c9c9c9",
        float_color = "#1a1d24",
      },
      astrodark = {
        -- Extend or modify astrodarks palette colors
        -- red = "#800010", -- Overrides astrodarks red color
        -- my_color = "#000000", -- Overrides global.my_color
        fg = "#abb2bf",
        bg = "#1e222a",
        ui = {
          selection = "#2c323c",
        },
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
          -- print(vim.inspect(C))
          -- C.ui.base = C.bg
          -- C.ui.orange = "#f1a971"
          -- C.ui.accent = "#f1a971"
          --
          C.term.black = C.ui.tabline
          C.term.bright_black = C.ui.base

          C.term.cyan = C.syntax.cyan
          C.term.bright_cyan = C.syntax.cyan

          C.term.white = C.fg
          C.term.bright_white = C.fg

          C.term.background = C.bg
          C.term.foreground = C.fg

          hl.Comment.italic = true
          hl.DiagnosticError.italic = true
          hl.DiagnosticHint.italic = true
          hl.DiagnosticWarn.italic = true
          hl.DiagnosticInfo = { italic = true, fg = C.bright_white }

          hl.TelescopePromptTitle = { fg = C.bg, bg = C.syntax.cyan }
          hl.TelescopePromptBorder = { fg = C.ui.selection, bg = C.ui.selection }
          hl.TelescopePromptNormal = { fg = C.fg, bg = C.ui.selection }

          hl.TelescopeSelection = { fg = C.white, bg = C.ui.selection }

          hl.TelescopePreviewTitle = { fg = C.bg, bg = C.syntax.green }
          hl.TelescopePreviewBorder = { fg = C.bg, bg = C.bg }
          hl.TelescopePreviewNormal = { bg = C.bg }

          hl.TelescopeResultsTitle = { fg = C.bg, bg = C.syntax.yellow }
          hl.TelescopeResultsBorder = { fg = C.bg, bg = C.bg }
          hl.TelescopeResultsNormal = { bg = C.bg }
          hl.TelescopeResultsDiffChange = { bg = C.NONE, fg = C.syntax.yellow }
          hl.TelescopeResultsDiffDelete = { bg = C.NONE, fg = C.syntax.red }
          hl.TelescopeResultsDiffAdd = { bg = C.NONE, fg = C.syntax.green }
          hl.TelescopeResultsDiffUntracked = { bg = C.NONE, fg = C.ui.winbar }

          hl.DashboardHeader = { fg = C.ui.selection }
          hl.DashboardTasks = { fg = C.ui.purple }
          hl.DashboardFooter = { fg = C.syntax.mute }

          -- hl.Normal = { fg = C.fg, bg = C.bg }
          -- hl.FloatBorder = { fg = C.ui.text_inactive }
          -- hl.FloatTitle = { fg = C.ui.text_inactive }
          -- hl.NormalFloat = {
          --   bg = C.float_color,
          --   fg = C.ui.text_inactive,
          -- }
          -- -- --
          hl.DailyNote = { fg = C.syntax.yellow }
          hl.ReferenceNote = { fg = C.ui.blue }
          hl.SlipNote = { fg = C.syntax.green }
          hl.JournalNote = { fg = C.light_purple }
          hl.ProjectNote = { fg = C.syntax.cyan }
          -- --
          -- hl["@text.strong"] = { fg = C.fg, bold = true }
          -- hl["@text.emphasis"] = { fg = C.fg, italic = true }
          --
          hl["@h1"] = { fg = C.dark_orange }
          hl["@MarkdownHeaderMarkerH1"] = { fg = C.dark_orange }

          hl["@h2"] = { fg = C.ui.purple }
          hl["@MarkdownHeaderMarkerH2"] = { fg = C.ui.purple }

          hl["@h3"] = { fg = C.light_purple }
          hl["@MarkdownHeaderMarkerH3"] = { fg = C.icon.pkg }

          hl["@h4"] = { fg = C.syntax.cyan }
          hl["@MarkdownHeaderMarkerH4"] = { fg = C.syntax.cyan }

          hl["@h5"] = { fg = C.syntax.yellow }
          hl["@MarkdownHeaderMarkerH5"] = { fg = C.syntax.yellow }

          hl["@h6"] = { fg = C.ui.orange }
          hl["@MarkdownHeaderMarkerH6"] = { fg = C.ui.orange }
          --
          -- hl["@text.reference"] = { fg = C.ui.blue }
          -- hl["@text.emphasis"].fg = C.white
          -- hl["@text.strong"].fg = C.white
          -- hl["@punctuation.delimiter"] = { fg = C.syntax.yellow }
          --
          hl["@MarkdownBlockQuote"] = { fg = C.surface2, italic = true }
          hl["@MarkdownMeta"] = { link = "Comment" }
          hl["@MarkdownInlineBlockCode"] = { fg = C.syntax.green, bg = C.black }
          hl["@MarkdownCodeBlockBG"] = { bg = C.black }
          hl["@MarkdownTableHeaderCell"] = { link = "BufferInactiveMod" }
          hl["@MarkdownTable"] = { link = "BufferVisibleTarget" }
          hl["@MarkdownListItemMarker"] = { link = "@comment" }
          hl["@MarkdownTag"] = { link = "@constant" }
          hl["@MarkdownTagItem"] = { link = "@constant" }
          hl["@MarkdownHorizontalLine"] = { fg = C.syntax.red, bg = C.syntax.mute }
          hl["SpellBad"] = { sp = "red", undercurl = true }
          hl["SpellCap"] = { sp = "yellow", undercurl = true }
          hl["SpellRare"] = { sp = "blue", undercurl = true }
          hl["SpellLocal"] = { sp = "red", undercurl = true }
          -- hl["@text.note"] = { link = "@constant" }
          --
          hl["STS_highlight"] = { fg = "#00F1F5" }
        end,
      },
    },
  }
end
