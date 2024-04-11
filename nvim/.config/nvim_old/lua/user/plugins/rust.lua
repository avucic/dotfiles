return {
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
    ft = "toml",
  },
  {
    "mattn/webapi-vim",
    ft = { "rust" },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },

    init = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- you can also put keymaps in here
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format()
                end,
              })
            end
          end,
          settings = function(project_root)
            local ra = require("rustaceanvim.config.server")
            return ra.load_rust_analyzer_settings(project_root, {
              settings_file_pattern = ".rust-analyzer.json",
            })
          end,
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },
}
