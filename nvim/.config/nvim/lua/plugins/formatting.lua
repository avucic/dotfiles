return {
  {
    "stevearc/conform.nvim",
    -- optional = true,
    config = function()
      local util = require "conform.util"
      require("conform").setup {
        -- log_level = vim.log.levels.DEBUG,
        format_on_save = function(bufnr)
          if vim.g.disable_conform_on_save or vim.b[bufnr].disable_conform_on_save then return end
          -- local disable_filetypes = { c = false, cpp = false }
          return {
            timeout_ms = 5000,
            -- set here per filetype
            -- lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            lsp_fallback = true,
          }
        end,
        default_format_opts = {
          lsp_format = "fallback",
        },

        format_after_save = {
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          javascript = { "eslint" },
          typescript = { "eslint" },
          typescriptreact = { "eslint" },
        },
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
          -- eslint = {
          --   command = util.find_executable({
          --     "node_modules/.bin/eslint",
          --     "eslint",
          --   }, "eslint"),
          --   args = { "format", "--stdin-filename", "$FILENAME" },
          --   stdin = true,
          --   cwd = util.root_file { "eslint.config.js", "package.json", ".git" },
          -- },
        },
      }
    end,
  },
}
