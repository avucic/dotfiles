if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
        integrations = {
          blink_cmp = true,
          cmp = false,
          gitsigns = true,
          neogit = true,
          diffview = true,
          flash = true,
          harpoon = true,
          mason = true,
          mini = { enabled = true },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          neotest = true,
          noice = true,
          notify = false,
          nvimtree = false,
          oil = true,
          overseer = true,
          render_markdown = true,
          snacks = { enabled = true },
          telescope = { enabled = false },
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      }

      vim.cmd.colorscheme "catppuccin"

      local c = {
        base = "#1e1e2e",
        mantle = "#181825",
        crust = "#11111b",
        surface0 = "#313244",
        overlay0 = "#6c7086",
        text = "#cdd6f4",
        blue = "#89b4fa",
        green = "#a6e3a1",
        yellow = "#f9e2af",
        peach = "#fab387",
        teal = "#94e2d5",
        mauve = "#cba6f7",
      }
      local hl = vim.api.nvim_set_hl

      hl(0, "DashboardDev", { fg = c.blue, bold = true })
      hl(0, "DashboardDevText", { fg = c.text })
      hl(0, "DashboardRemote", { fg = c.green, bold = true })

      hl(0, "NormalFloat", { bg = c.mantle })
      hl(0, "FloatBorder", { fg = c.mantle, bg = c.mantle })
      hl(0, "FloatTitle", { fg = c.text, bg = c.mantle, bold = true })

      hl(0, "SnacksPicker", { bg = c.mantle })
      hl(0, "SnacksPickerBorder", { fg = c.mantle, bg = c.mantle })
      hl(0, "SnacksPickerTitle", { fg = c.mantle, bg = c.mauve, bold = true })
      hl(0, "SnacksPickerInputTitle", { fg = c.mantle, bg = c.mauve, bold = true })
      hl(0, "SnacksPickerPreviewTitle", { fg = c.mantle, bg = c.teal, bold = true })
      hl(0, "SnacksPickerListTitle", { fg = c.mantle, bg = c.peach, bold = true })
      hl(0, "SnacksPickerBoxTitle", { fg = c.mantle, bg = c.peach, bold = true })
      hl(0, "SnacksPickerPreview", { bg = c.base })
      hl(0, "SnacksPickerInput", { bg = c.mantle })
      hl(0, "SnacksPickerDir", { fg = c.overlay0 })
      hl(0, "SnacksPickerListCursorLine", { bg = c.surface0 })
      hl(0, "SnacksPickerToggleOn", { fg = c.mantle, bg = c.mauve })
      hl(0, "SnacksPickerToggleOff", { fg = c.overlay0 })
      hl(0, "SnacksNotifierBorder", { fg = c.mantle, bg = c.mantle })

      hl(0, "BlinkCmpMenu", { bg = c.mantle, fg = c.text })
      hl(0, "BlinkCmpMenuBorder", { fg = c.mantle, bg = c.mantle })
      hl(0, "BlinkCmpDoc", { bg = c.mantle, fg = c.text })
      hl(0, "BlinkCmpDocBorder", { fg = c.mantle, bg = c.mantle })
      hl(0, "BlinkCmpMenuSelection", { bg = c.surface0, bold = false })
      hl(0, "BlinkCmpScrollBarGutter", { bg = c.mantle })
      hl(0, "BlinkCmpSignatureHelpBorder", { fg = c.mantle, bg = c.mantle })

      hl(0, "WhichKeyNormal", { bg = c.mantle })
      hl(0, "WhichKeyBorder", { fg = c.mantle, bg = c.mantle })

      hl(0, "DiagnosticFloatingError", { italic = true })
      hl(0, "DiagnosticFloatingWarn", { italic = true })
      hl(0, "DiagnosticFloatingInfo", { italic = true, fg = "#cdd6f4" })
      hl(0, "DiagnosticFloatingHint", { italic = true, fg = c.blue })

      -- Mini.tabline: current tab bold+italic on editor bg, no red underline
      hl(0, "MiniTablineCurrent", { fg = c.text, bg = c.base, bold = true, italic = true })
      hl(0, "MiniTablineVisible", { fg = c.subtext1, bg = c.mantle })
      hl(0, "MiniTablineHidden", { fg = c.overlay0, bg = c.mantle })
      hl(0, "MiniTablineModifiedCurrent", { fg = c.red, bg = c.base, bold = true, italic = true })
      hl(0, "MiniTablineModifiedVisible", { fg = c.red, bg = c.mantle })
      hl(0, "MiniTablineModifiedHidden", { fg = c.red, bg = c.mantle })
      hl(0, "MiniTablineFill", { bg = c.mantle })
    end,
  },
}
