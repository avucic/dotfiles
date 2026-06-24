return {
  -- ── nvim-ufo (folding) ────────────────────────────────────────────────────────
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    config = function()
      -- Subtle catppuccin-matching fold highlights
      vim.api.nvim_set_hl(0, "Folded", { bg = "#313244", fg = "#6c7086" })
      vim.api.nvim_set_hl(0, "UfoFoldedDots", { fg = "#45475a" })
      vim.api.nvim_set_hl(0, "UfoFoldedCount", { fg = "#89b4fa" })

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          if buftype ~= "" then
            return "indent"
          end
          local has_parser = pcall(vim.treesitter.get_parser, bufnr, filetype)
          local has_folds = has_parser and vim.treesitter.query.get(filetype, "folds") ~= nil
          return has_folds and { "lsp", "treesitter" } or { "lsp", "indent" }
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = string.format("  %d lines ", endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0

          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              table.insert(newVirtText, { chunkText, chunk[2] })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              break
            end
            curWidth = curWidth + chunkWidth
          end

          local padding = targetWidth - curWidth
          if padding > 0 then
            table.insert(newVirtText, { string.rep("·", padding), "UfoFoldedDots" })
          end
          table.insert(newVirtText, { suffix, "UfoFoldedCount" })
          return newVirtText
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    end,
  },

  -- ── mini.nvim (icons + pairs) ────────────────────────────────────────────────
  {
    "echasnovski/mini.nvim",
    lazy = false,
    priority = 850,
    config = function()
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
      require("mini.pairs").setup()
      require("mini.bufremove").setup()
    end,
  },

  -- ── bufferline ────────────────────────────────────────────────────────────────
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    priority = 840,
    dependencies = { "echasnovski/mini.nvim" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "none",
          close_command = function(n)
            MiniBufremove.delete(n, false)
          end,
          right_mouse_command = function(n)
            MiniBufremove.delete(n, false)
          end,
          indicator = { style = "none" },
          buffer_close_icon = "×",
          close_icon = "×",
          modified_icon = "●",
          show_buffer_icons = true,
          show_close_icon = false,
          show_buffer_close_icons = true,
          separator_style = { "", "" }, -- no separators between tabs
          always_show_bufferline = true,
          offsets = {},
          get_element_icon = function(elem)
            if type(elem.filename) ~= "string" or elem.filename == "" then
              return
            end
            local icon, hl = MiniIcons.get("file", elem.filename)
            return icon, hl
          end,
        },
        highlights = (function()
          local c = {
            base = "#1e1e2e",
            mantle = "#181825",
            surface0 = "#313244",
            overlay0 = "#6c7086",
            text = "#cdd6f4",
            subtext1 = "#bac2de",
            red = "#f38ba8",
            green = "#a6e3a1",
          }
          local function tab(fg, bg, extra)
            return vim.tbl_extend("force", { fg = fg, bg = bg }, extra or {})
          end
          return {
            fill = tab(c.text, c.mantle),
            background = tab(c.overlay0, c.mantle),
            buffer_selected = tab(c.text, c.base, { bold = true, italic = true }),
            buffer_visible = tab(c.subtext1, c.mantle),
            close_button = tab(c.overlay0, c.mantle),
            close_button_selected = tab(c.red, c.base),
            close_button_visible = tab(c.overlay0, c.mantle),
            modified = tab(c.green, c.mantle),
            modified_selected = tab(c.green, c.base),
            modified_visible = tab(c.green, c.mantle),
            separator = tab(c.mantle, c.mantle),
            separator_selected = tab(c.mantle, c.mantle),
            indicator_selected = tab(c.base, c.base),
            tab_selected = tab(c.text, c.base),
            tab = tab(c.overlay0, c.mantle),
            tab_close = tab(c.red, c.mantle),
          }
        end)(),
      })

      local function bmap(key, action, desc)
        vim.keymap.set("n", "<Leader>b" .. key, action, { desc = desc })
      end

      local bl = require("bufferline")

      -- Navigation
      bmap("h", "<cmd>BufferLineCyclePrev<cr>", "Previous buffer")
      bmap("l", "<cmd>BufferLineCycleNext<cr>", "Next buffer")

      -- Pick
      bmap("b", function()
        bl.pick()
      end, "Pick buffer")
      bmap("d", "<cmd>BufferLinePickClose<cr>", "Pick buffer to close")

      -- Close
      bmap("q", function()
        MiniBufremove.delete(0, false)
      end, "Close buffer")
      bmap("Q", function()
        MiniBufremove.delete(0, true)
      end, "Force close buffer")
      bmap("c", "<cmd>BufferLineCloseOthers<cr>", "Close other buffers")
      bmap("o", "<cmd>BufferLineCloseOthers<cr>", "Close other buffers")
      bmap("L", "<cmd>BufferLineCloseLeft<cr>", "Close buffers to the left")
      bmap("r", "<cmd>BufferLineCloseRight<cr>", "Close buffers to the right")
      bmap("R", "<cmd>BufferLineCloseRight<cr>", "Close buffers to the right")

      bmap("C", function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].buflisted then
            MiniBufremove.delete(buf, false)
          end
        end
      end, "Close all buffers")
      bmap("O", function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].buflisted then
            MiniBufremove.delete(buf, false)
          end
        end
      end, "Close all buffers")

      bmap("D", function()
        local visible = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          visible[vim.api.nvim_win_get_buf(win)] = true
        end
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].buflisted and not visible[buf] then
            MiniBufremove.wipeout(buf, false)
          end
        end
      end, "Wipeout hidden buffers")

      -- Sort
      bmap("s", "<cmd>BufferLineSortByExtension<cr>", "Sort buffers")

      -- Split from tabline
      local function pick_split(cmd)
        Snacks.picker.buffers({
          actions = {
            confirm = function(picker, item)
              picker:close()
              if item then
                vim.cmd(cmd .. " | buffer " .. item.buf)
              end
            end,
          },
        })
      end
      bmap("\\", function()
        pick_split("split")
      end, "Horizontal split buffer from tabline")
      bmap("|", function()
        pick_split("vsplit")
      end, "Vertical split buffer from tabline")
    end,
  },

  -- ── which-key ────────────────────────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        preset = "modern",
        delay = 500,
        win = {
          no_overlap = false,
          col = 0,
          row = math.huge,
          width = 9999,
          border = "none",
          padding = { 1, 2 },
        },
        spec = {
          { "<Leader>b", group = "Buffers", icon = "󰓩" },
          { "<Leader>d", group = "Debug", icon = "󰃤" },
          { "<Leader>c", group = "Container/Remote", icon = "󰡨" },
          { "<Leader>rc", group = "DevContainer", icon = "󰡨" },
          { "<Leader>e", group = "Explorer", icon = "󰙅" },
          { "<Leader>f", group = "Files", icon = "󰈔" },
          { "<Leader>g", group = "Git", icon = "󰊢" },
          { "<Leader>gn", group = "New" },
          { "<Leader>l", group = "LSP", icon = "󰒓" },
          { "<Leader>m", group = "Local mappings", icon = "󰌌" },
          { "<Leader>n", group = "Notes", icon = "󰎞" },
          { "<Leader>nd", group = "Daily", icon = "󰃭" },
          { "<Leader>o", group = "Open", icon = "󰏋" },
          { "<Leader>q", group = "Diagnostics", icon = "󰒡" },
          { "<Leader>s", group = "Search",  icon = "󰍉" },
          { "<Leader>S", group = "Session", icon = "󰆓" },
          { "<Leader>t", group = "Tasks/Tests", icon = "󰙨" },
          { "<Leader>u", group = "Toggles", icon = "󰔡" },
          { "<Leader>x", group = "Text", icon = "󰉿" },
          { "<Leader>xi", group = "Text Case" },
          { "<Leader>xa", group = "Align", mode = "v" },
          { "<Leader>z", group = "Spelling", icon = "󰓆" },
          { "<Leader>:", group = "AI", icon = "󱙺" },
          { "<C-w>", group = "Windows", icon = "󱒕" },
          { "<C-w>t", group = "Tabs", icon = "󰓩" },
          { ",", group = "Multi-cursor", icon = "󰆿" },
          { "m", group = "Marks/Harpoon", icon = "󰛢" },
        },
      })
    end,
  },

  -- ── heirline (statusline) ────────────────────────────────────────────────────
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.nvim" },
    config = function()
      local conditions = require("heirline.conditions")

      local p = {
        base = "#1e1e2e",
        mantle = "#181825",
        surface0 = "#313244",
        surface1 = "#45475a",
        surface2 = "#585b70",
        overlay0 = "#6c7086",
        overlay1 = "#7f849c",
        text = "#cdd6f4",
        subtext1 = "#bac2de",
        subtext0 = "#a6adc8",
        blue = "#89b4fa",
        green = "#a6e3a1",
        yellow = "#f9e2af",
        peach = "#fab387",
        mauve = "#cba6f7",
        teal = "#94e2d5",
        red = "#f38ba8",
      }

      local mode_colors = {
        n = p.blue,
        i = p.green,
        v = p.mauve,
        V = p.mauve,
        ["\22"] = p.mauve,
        c = p.peach,
        s = p.teal,
        S = p.teal,
        ["\19"] = p.teal,
        R = p.red,
        r = p.red,
        ["!"] = p.red,
        t = p.green,
      }
      local function mode_color()
        return mode_colors[vim.fn.mode()] or p.blue
      end

      local Align = { provider = "%=" }
      local Space = { provider = " " }

      local GitBranch = {
        condition = function()
          return vim.b.gitsigns_head ~= nil
        end,
        update = { "BufEnter", "BufWritePost" },
        {
          provider = function()
            return "   " .. vim.b.gitsigns_head .. " "
          end,
          hl = { fg = p.mauve },
        },
        {
          provider = function()
            local d = vim.b.gitsigns_status_dict or {}
            local parts = {}
            if (d.added or 0) > 0 then
              parts[#parts + 1] = "+" .. d.added
            end
            if (d.changed or 0) > 0 then
              parts[#parts + 1] = "~" .. d.changed
            end
            if (d.removed or 0) > 0 then
              parts[#parts + 1] = "-" .. d.removed
            end
            return #parts > 0 and (table.concat(parts, " ") .. " ") or ""
          end,
          hl = function()
            local d = vim.b.gitsigns_status_dict or {}
            if (d.removed or 0) > 0 then
              return { fg = p.red }
            elseif (d.changed or 0) > 0 then
              return { fg = p.yellow }
            else
              return { fg = p.green }
            end
          end,
        },
      }

      local FileType = {
        init = function(self)
          self.ft = vim.bo.filetype
          if self.ft ~= "" then
            self.icon, self.icon_hl = MiniIcons.get("filetype", self.ft)
          end
        end,
        {
          provider = function(self)
            return self.ft ~= "" and (" " .. self.icon) or ""
          end,
          hl = function(self)
            return self.ft ~= "" and self.icon_hl or {}
          end,
        },
        {
          provider = function(self)
            return self.ft ~= "" and (" " .. self.ft) or ""
          end,
          hl = { fg = p.subtext1 },
        },
      }

      local FileFlags = {
        {
          condition = function()
            return vim.bo.modified
          end,
          provider = "  ●",
          hl = { fg = p.green },
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = "  ",
          hl = { fg = p.red },
        },
      }

      local DiagE = {
        provider = function()
          local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          return n > 0 and (" 󰅚 " .. n) or ""
        end,
        hl = { fg = p.red },
        update = { "DiagnosticChanged", "BufEnter" },
      }
      local DiagW = {
        provider = function()
          local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
          return n > 0 and (" 󰀪 " .. n) or ""
        end,
        hl = { fg = p.yellow },
        update = { "DiagnosticChanged", "BufEnter" },
      }
      local DiagH = {
        provider = function()
          local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
          return n > 0 and (" 󰌶 " .. n) or ""
        end,
        hl = { fg = p.teal },
        update = { "DiagnosticChanged", "BufEnter" },
      }
      local DiagI = {
        provider = function()
          local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
          return n > 0 and ("  " .. n) or ""
        end,
        hl = { fg = "#89dceb" },
        update = { "DiagnosticChanged", "BufEnter" },
      }
      local Diagnostics = { DiagE, DiagW, DiagH, DiagI, Space }

      local LSPActive = {
        condition = conditions.lsp_attached,
        update = { "LspAttach", "LspDetach", "BufEnter" },
        provider = function()
          local names = {}
          for _, c in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            if c.name ~= "copilot" then
              names[#names + 1] = c.name
            end
          end
          return #names > 0 and (" 󰒓 " .. table.concat(names, ", ") .. " ") or ""
        end,
        hl = { fg = p.overlay1 },
      }

      local Treesitter = {
        condition = function()
          return pcall(vim.treesitter.get_parser, 0)
        end,
        provider = " 󰙅 TS ",
        hl = { fg = p.teal },
      }

      local EnvBadge = {
        condition = function()
          return vim.env.DEVCONTAINER or vim.env.REMOTE_NVIM
        end,
        provider = function()
          if vim.env.DEVCONTAINER then
            local cwd = vim.fn.getcwd()
            local svc = cwd:match("/services/([^/]+)") or vim.fn.fnamemodify(cwd, ":t")
            return " DEV:" .. svc .. " "
          end
          return " REMOTE "
        end,
        hl = function()
          return { fg = p.mantle, bg = vim.env.DEVCONTAINER and p.blue or p.peach, bold = true }
        end,
      }

      local Ruler = { provider = " %l:%c ", hl = { fg = p.subtext0 } }
      local ScrollBar = {
        static = { sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" } },
        provider = function(self)
          local line = vim.api.nvim_win_get_cursor(0)[1]
          local total = vim.api.nvim_buf_line_count(0)
          local i = total < 2 and 1 or math.floor((line - 1) / (total - 1) * (#self.sbar - 1)) + 1
          return self.sbar[i] .. self.sbar[i]
        end,
        hl = { fg = p.peach, bg = p.mantle },
      }
      local Mode = {
        provider = "█",
        hl = function()
          return { fg = mode_color() }
        end,
        update = { "ModeChanged", pattern = "*:*" },
      }

      local StatusLine = {
        hl = { bg = p.mantle, fg = p.text },
        Mode,
        EnvBadge,
        Space,
        FileType,
        FileFlags,
        GitBranch,
        Diagnostics,
        Align,
        LSPActive,
        Treesitter,
        Ruler,
        ScrollBar,
      }
      local InactiveStatusLine = {
        condition = conditions.is_not_active,
        hl = { bg = p.mantle, fg = p.overlay0 },
        Space,
        FileType,
        FileFlags,
      }

      require("heirline").setup({
        statusline = { fallthrough = false, InactiveStatusLine, StatusLine },
      })
    end,
  },

  -- ── nvim-web-devicons (compat shim provided by mini.icons) ───────────────────
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ── todo-comments ────────────────────────────────────────────────────────────
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
      local map = function(lhs, rhs, opts)
        vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", { silent = true }, opts or {}))
      end
      map("]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next TODO" })
      map("[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Prev TODO" })
      map("<Leader>st", function()
        require("todo-comments.snacks").pick()
      end, { desc = "Todo list" })
    end,
  },

  -- ── nvim-highlight-colors ────────────────────────────────────────────────────
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPost",
    config = function()
      require("nvim-highlight-colors").setup({ render = "background", enable_tailwind = true })
    end,
  },

  -- ── nvim-bqf ─────────────────────────────────────────────────────────────────
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("bqf").setup()
    end,
  },

  -- ── trouble.nvim ──────────────────────────────────────────────────────────────
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<Leader>qq", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document diagnostics" },
      { "<Leader>qw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
      { "<Leader>qQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
      { "<Leader>ql", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<Leader>qr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP references" },
    },
    config = function()
      require("trouble").setup({ use_diagnostic_signs = true })
    end,
  },

  -- ── aerial.nvim (code outline) ────────────────────────────────────────────────
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    keys = {
      {
        "<Leader>os",
        function()
          local aerial = require("aerial")
          local aerial_open = false
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "aerial" then
              aerial_open = true
              break
            end
          end
          if aerial_open then
            aerial.close()
          else
            aerial.open({ focus = false })
          end
        end,
        desc = "Symbols outline",
      },
      {
        "<Leader>oS",
        function()
          vim.g.aerial_auto_open = not vim.g.aerial_auto_open
          if vim.g.aerial_auto_open then
            vim.cmd("AerialOpen!")
          else
            vim.cmd("AerialClose")
          end
          vim.notify("Aerial auto-open: " .. (vim.g.aerial_auto_open and "on" or "off"))
        end,
        desc = "Toggle aerial auto-open",
      },
    },
    config = function()
      vim.g.aerial_auto_open = true
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr, desc = "Prev symbol" })
          vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr, desc = "Next symbol" })
        end,
        layout = { max_width = { 40, 0.2 }, min_width = 25 },
        attach_mode = "global",

        open_automatic = function(bufnr)
          return vim.g.aerial_auto_open and vim.api.nvim_buf_line_count(bufnr) > 100
        end,
      })
      if vim.api.nvim_buf_line_count(0) > 100 then
        vim.defer_fn(function() vim.cmd("AerialOpen!") end, 200)
      end
    end,
  },
}
