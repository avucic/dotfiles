return {
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    dependencies = {
      "nvim-neotest/neotest-jest",
      "olimorris/neotest-rspec",
      {
        "mrcjkb/rustaceanvim",
        -- To avoid being surprised by breaking changes,
        -- I recommend you set a version range
        version = "^9",
        -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
        -- No need for lazy.nvim to lazy-load it.
        lazy = false,
      },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          opts.mappings = opts.mappings or {}

          opts.mappings.n = vim.tbl_extend("force", opts.mappings.n or {}, {
            ["<leader>tt"] = {
              function() require("neotest").run.run() end,
              desc = "Run nearest test",
            },
            ["<leader>tf"] = {
              function() require("neotest").run.run(vim.fn.expand "%") end,
              desc = "Run test file",
            },
            ["<leader>td"] = {
              function() require("neotest").run.run { vim.fn.expand "%", strategy = "dap", suite = false } end,
              desc = "Debug nearest test",
            },
            ["<leader>ts"] = {
              function() require("neotest").summary.toggle() end,
              desc = "Toggle test summary",
            },
            ["<leader>to"] = {
              function() require("neotest").output.open { enter = true } end,
              desc = "Open test output",
            },
            ["<leader>tO"] = {
              function() require("neotest").output_panel.toggle() end,
              desc = "Toggle output panel",
            },
            ["<leader>tS"] = {
              function() require("neotest").run.stop() end,
              desc = "Stop tests",
            },
          })
        end,
      },
    },
    cmd = { "Neotest" },
    -- keys = {
    --   { "<Leader>tn", "<cmd>Neotest run<cr>", desc = "Run current" },
    --   { "<Leader>tT", "<cmd>Neotest<cr>", desc = "Run tests" },
    --   { "<Leader>tF", "<cmd>Neotest file<cr>", desc = "Run tests in file" },
    --   { "<Leader>tA", "<cmd>Neotest suite<cr>", desc = "Run tests in suite" },
    -- },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}

      -- RSpec
      table.insert(
        opts.adapters,
        require "neotest-rspec" {
          rspec_cmd = function() return { "bundle", "exec", "rspec" } end,
        }
      )
      table.insert(
        opts.adapters,
        require "neotest-jest" {
          jestCommand = "npm test --",
          -- jestArguments = function(defaultArguments, context) return defaultArguments end,
          -- jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path) return vim.fn.getcwd() end,
          isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
        }
      )
    end,
  },
}
