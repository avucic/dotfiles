local M = {}

function M.config()
  return {
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = {
        "sumneko_lua",
        "solargraph",
        "gopls",
        "tsserver",
        "html",
        "cssls",
        "yamlls",
        "sqlls",
        "eslint",
        "vimls",
        "marksman",
        "zk@v0.11.1",
        "zk",
        "grammarly"
      },
    },
    -- TODO
    -- use mason-tool-installer to configure DAP/Formatters/Linter installation
    ["mason-tool-installer"] = { -- overrides `require("mason-tool-installer").setup(...)`
      ensure_installed = {
        "prettier",
        "stylua",
        "gopls",
        "marksman",
        "zk@v0.11.1",
      },
    },
    ["mason-null-ls"] = {},
  }
end

return M
