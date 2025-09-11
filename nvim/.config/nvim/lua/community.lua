-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.
--
---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.recipes.ai" },
  --
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.pack.ruby" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.go" },
  -- -- { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.markdown" },
  -- -- { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.biome" },
  -- { import = "astrocommunity.pack.html-css" },

  -- TODO:
  -- 1.fix telescope-nvchad-theme
  -- 2. lazy load some plugins like dial, leap, harpoon

  -- { import = "astrocommunity.markdown-and-latex.markview-nvim" },
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.code-runner.sniprun" },
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },
  { import = "astrocommunity.editing-support.text-case-nvim" },
  { import = "astrocommunity.editing-support.treesj" },
  -- { import = "astrocommunity.editing-support.true-zen-nvim" },
  { import = "astrocommunity.editing-support.yanky-nvim" },
  { import = "astrocommunity.file-explorer.oil-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  -- { import = "astrocommunity.motion.before-nvim" }, -- jump to lst edit
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.mini-move" }, -- move lines
  { import = "astrocommunity.motion.nvim-spider" }, -- jump to part of the word text objects
  { import = "astrocommunity.motion.nvim-surround" },
  -- { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.note-taking.zk-nvim" },
  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.utility.nvim-toggler" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.neogit" },

  -- { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
  -- { import = "astrocommunity.debugging.telescope-dap-nvim" },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>od"] = { desc = "DB" }
          maps.n["<Leader>odt"] = { "<cmd>DBUIToggle<cr>", desc = "Toggle DB Connection" }
        end,
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFocusFiles",
      "DiffviewFileHistory",
      "DiffviewRefresh",
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>gd"] = { desc = "Diff" }
          maps.n["<Leader>gdo"] = { "<cmd>DiffviewOpen<cr>", desc = "DiffView" }
          maps.n["<Leader>gdq"] = { ":q<cr>", desc = "Diff close" }
          maps.n["<Leader>gh"] = { "<cmd>DiffviewFileHistory %<cr>", desc = "History" }
          maps.n["<Leader>gR"] = { "<cmd>DiffviewRefresh<cr>", desc = "Refresh" }
        end,
      },
    },
    opts = function(_, opts)
      opts.keymaps = {
        view = {
          ["<C-q>"] = "<Cmd>DiffviewClose<CR>",
          ["q"] = "<Cmd>DiffviewClose<CR>",
        },
      }
    end,
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      "junegunn/fzf",
      run = function() vim.fn["fzf#install"]() end,
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    config = function()
      vim.cmd [[
        hi RenderMarkdownH1Bg guifg=#828bb8 guibg=#202333
        hi RenderMarkdownH2Bg guifg=#41a6b5 guibg=#17242B
        hi RenderMarkdownH3Bg guifg=#b36900 guibg=#282427
        hi RenderMarkdownH4Bg guifg=#4fd6be guibg=#17242B
        hi RenderMarkdownH5Bg guifg=#82aaff guibg=#202333
        hi RenderMarkdownH6Bg guifg=#636da6 guibg=#202333

        hi RenderMarkdownH1 guifg=#828bb8 guibg=#202333
        hi RenderMarkdownH2 guifg=#41a6b5 guibg=#17242B
        hi RenderMarkdownH3 guifg=#b36900 guibg=#282427
        hi RenderMarkdownH4 guifg=#4fd6be guibg=#17242B
        hi RenderMarkdownH5 guifg=#82aaff guibg=#202333
        hi RenderMarkdownH6 guifg=#636da6 guibg=#202333
      ]]
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>fe"] = { "<cmd>lua require('oil').toggle_float()<cr>", desc = "Oil file explorer" }
          maps.n["<Leader>fE"] =
            { "<cmd>lua require('oil').toggle_float(vim.fn.getcwd())<cr>", desc = "Oil file explorer" }
          -- maps.n["<Leader>fE"] = { "<cmd>OilBookmarks<cr>", desc = "Oil explorer bookmarks" }
          maps.n["<Leader>O"] = nil
        end,
      },
    },
    opts = function(_, opts)
      opts.default_file_explorer = true
      opts.keymaps = {
        ["<C-w>v"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-w>s"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = false,
        ["<C-h>"] = false,
        -- ["<C-s>"] = false,
        -- ["<C-v>"] = false,
        ["."] = false,
        -- ["h"] = { "actions.parent", desc = "Parent" },
        -- ["l"] = { "actions.select", desc = "Select" },
        ["R"] = { "actions.refresh", desc = "Refresh" },
        ["q"] = { "actions.close", desc = "Close" },
        ["P"] = { "actions.preview", desc = "Preview" },
        ["<c-d>"] = { "actions.preview_scroll_down", desc = "Preview down" },
        ["<c-u>"] = { "actions.preview_scroll_up", desc = "Preview up" },
        ["mm"] = {
          function()
            local oil = require "oil"
            local dir = oil.get_current_dir()
            require("plugins.custom.oil_explorer_bookmarks").create_bookmark(dir)
          end,
          desc = "Bookmark",
        },
      }

      opts.float = {
        -- padding = 20,
        -- max_width = 0,
        -- max_height = 0,
        -- border = "rounded",
        -- win_options = {
        --   winblend = 0,
        --   winhighlight = "NormalFloat:Telescope",
        -- },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "auto",
      }
    end,
  },

  -- to fix luautf8 issue
  -- luarocks install luautf8 --lua-version=5.1
  -- luarocks install toml-edit --lua-version=5.1
  {
    "zk-org/zk-nvim",
    dependencies = {
      "nvim-neorocks/toml-edit.lua",
      {
        "vhyrro/luarocks.nvim",

        priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
        config = true,
        opts = {
          ["toml-edit"] = { "toml-edit" }, -- specifies a list of rocks to install
          ["luautf8"] = { "luautf8" },
          -- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
          --   },
        },
      },
    },
    config = function(_, opts) require("plugins.custom.zk").config(opts) end,
    opts = {
      picker = "telescope",
      -- lsp = {
      --   -- `config` is passed to `vim.lsp.start(config)`
      --   config = {
      --     name = "zk",
      --     cmd = { "zk", "lsp" },
      --     filetypes = { "markdown" },
      --     -- on_attach = ...
      --     -- etc, see `:h vim.lsp.start()`
      --   },
      --
      --   -- automatically attach buffers in a zk notebook that match the given filetypes
      --   auto_attach = {
      --     enabled = true,
      --   },
      -- },

      -- picker_options = {
      --   snacks_picker = {
      --     layout = {
      --       preset = "ivy",
      --     },
      --   },
      -- },
    },
    cmd = {
      "ZkOrphahs",
      "ZkLink",
      "ZkGrep",
      "ZkIndex",
      "ZkNew",
      -- "ZkNewFromTitleSelection",
      "ZkNewFromContentSelection",
      "ZkCd",
      "ZkNotes",
      "ZkBacklinks",
      "ZkLinks",
      "ZkInsertLinkAtSelection",
      "ZkInsertLink",
      "ZkMatch",
      "ZkTags",
      "ZkOpenNotebook",
      "ZkFindOrCreate",
      "ZkFindOrCreateJournalDailyNote",
      "ZkOpenNotes",
      "ZkFindOrCreateNote",
      "ZkFindOrCreateProjectNote",
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          maps.x["gV"] = maps.x["S"]
          maps.o["gV"] = maps.o["S"]
          maps.n["gV"] = maps.n["S"]

          -- maps.x["S"] = nil
          -- maps.o["S"] = nil
          -- maps.n["S"] = nil
        end,
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>y"] = { desc = "Yank" }
          maps.n["<Leader>yy"] = { "<cmd>lua Snacks.picker.yanky() <cr>", desc = "Yank history" }
          maps.v["<Leader>yy"] = { "<cmd>lua Snacks.picker.yanky() <cr>", desc = "Yank history" }
        end,
      },
    },
  },
  {
    "stevearc/overseer.nvim",
    init = function(_)
      require("astrocore").set_mappings {
        n = {
          ["<Leader>t<cr>"] = { "<cmd>OverseerToggle<cr>", desc = "Toggle" },
          ["<Leader>tt"] = { "<cmd>OverseerRun<cr>", desc = "Run" },
          ["<Leader>tl"] = { "<cmd>OverseerRestartLast<cr>", desc = "last task" },
          ["<Leader>ta"] = { "<cmd>OverseerQuickAction<cr>", desc = "Task action" },
        },
      }
    end,
    cmd = { "OverseerRestartLast" },
    opts = {
      strategy = {
        "toggleterm",
        -- load your default shell before starting the task
        use_shell = false,
        -- overwrite the default toggleterm "direction" parameter
        direction = "horizontal",
        -- overwrite the default toggleterm "highlights" parameter
        highlights = nil,
        -- overwrite the default toggleterm "auto_scroll" parameter
        auto_scroll = nil,
        -- have the toggleterm window close and delete the terminal buffer
        -- automatically after the task exits
        close_on_exit = false,
        -- have the toggleterm window close without deleting the terminal buffer
        -- automatically after the task exits
        -- can be "never, "success", or "always". "success" will close the window
        -- only if the exit code is 0.
        quit_on_exit = "never",
        -- open the toggleterm window when a task starts
        open_on_start = true,
        -- mirrors the toggleterm "hidden" parameter, and keeps the task from
        -- being rendered in the toggleable window
        hidden = true,
        -- command to run when the terminal is created. Combine with `use_shell`
        -- to run a terminal command before starting the task
        on_create = nil,
      },
    },
    config = function(_, opts)
      local overseer = require "overseer"
      overseer.setup(opts)

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local tasks = overseer.list_tasks { recent_first = true }
        if vim.tbl_isempty(tasks) then
          Snacks.notify.warn "No tasks found"
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    end,
  },

  -- {
  --   "anuvyklack/windows.nvim",
  --   dependencies = {
  --     {
  --       "AstroNvim/astrocore",
  --       opts = function(_, opts)
  --         local maps = opts.mappings
  --         maps.n["<c-w>="] = { "<cmd>WindowsEqualize<CR><cmd>WindowsDisableAutowidth<cr>", desc = "Equalize" }
  --         maps.n["<c-w>z"] = { "<cmd>WindowsMaximize<CR>", desc = "Maximize" }
  --       end,
  --     },
  --   },
  -- },
  {
    "nguyenvukhang/nvim-toggler",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>xt"] = maps.n["<Leader>i"]
          maps.n["<Leader>"] = nil
        end,
      },
    },

    opts = {
      inverses = {
        ["build"] = "create",
        ["after"] = "before",
        ["required"] = "optional",
        ["key"] = "value",
        ["if"] = "unless",
        ["yes"] = "no",
        ["on"] = "off",
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.v["<leader>xi"] = { "<cmd>TextCaseOpenTelescope<CR>", desc = "Open Smart Case Telescope" }
        end,
      },
    },
  },
  {
    "Wansmer/treesj",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["gJ"] = maps.n["<Leader>m"]
          maps.n["<Leader>m"] = nil
        end,
      },
    },
  },

  {
    "michaelb/sniprun",
    init = function(_)
      require("astrocore").set_mappings {
        n = { ["<Leader>rr"] = { "<cmd>SnipRun<cr>", desc = "Execute" } },
        v = { ["<Leader>rr"] = { "<cmd>SnipRun<cr>", desc = "Execute" } },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    config = function()
      local util = require "conform.util"
      require("conform").setup {
        formatters = {
          biome = {
            command = util.find_executable({
              "node_modules/.bin/biome",
              "biome",
            }, "biome"),
            args = { "format", "--stdin-file-path", "$FILENAME" },
            stdin = true,
            cwd = util.root_file { "biome.json", "package.json", ".git" },
          },
        },
      }
    end,
    --   opts = function(_, opts)
    --     if not opts.formatters_by_ft then opts.formatters_by_ft = {} end
    --     if not opts.formatters then opts.formatters = {} end
    --     -- https://biomejs.dev/internals/language-support/
    --     -- local supported_ft = {
    --     --   "astro",
    --     --   "css",
    --     --   "graphql",
    --     --   "html",
    --     --   "javascript",
    --     --   "javascriptreact",
    --     --   "json",
    --     --   "jsonc",
    --     --   "markdown",
    --     --   "svelte",
    --     --   "typescript",
    --     --   "typescriptreact",
    --     --   "vue",
    --     --   "yaml",
    --     -- }
    --     -- for _, ft in ipairs(supported_ft) do
    --     --   opts.formatters_by_ft[ft] = { "biome" }
    --     -- end
    --
    --     table.insert(opts.formatters, {
    --       biome = {
    --         -- Use 'npx' to ensure the project's local 'biome' executable is used.
    --         -- 'npx' will automatically look for 'biome' in node_modules/.bin and then global.
    --         command = "npx",
    --         -- The 'args' are passed to 'npx biome ...'.
    --         -- '$FILENAME' is a placeholder replaced by conform with the current buffer's file path.
    --         args = { "biome", "format", "--stdin-file-path", "$FILENAME" },
    --       },
    --     })
    --   end,
  },
}
