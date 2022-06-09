local M = {}
function M.config()
  local lsp_installer = require("user.utils").load_module("nvim-lsp-installer")
  local map = vim.keymap.set

  local default_lsp_servers = {
    sumneko_lua = {},
    solargraph = {},
    gopls = {},
    tsserver = {},
    html = {},
    cssls = {},
    yamls = {},
    sqlls = {},
    eslint = {},
  }

  for name, _ in pairs(default_lsp_servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
      print("Installing " .. name)
      server:install()
      -- vim.cmd("LspInstallInfo")
    end
  end

  return {
    -- add to the server on_attach function
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

      require("aerial").on_attach(client, bufnr)

      -- require("lsp_signature").on_attach()
      -- TODO
      -- vim.cmd [[
      -- set shiftwidth=2
      -- set tabstop=2
      -- set expandtab
      -- ]]

      map("n", "<leader>lf", function()
        vim.lsp.buf.formatting_sync(nil, 2000)
      end, { desc = "Format code", buffer = bufnr })
    end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   server:setup(opts)
    -- end

    -- Add overrides for LSP server settings, the keys are the name of the server
    -- ["server-settings"] = {
    -- example for addings schemas to yamlls
    -- yamlls = {
    --   settings = {
    --     yaml = {
    --       schemas = {
    --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
    --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
    --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
    --       },
    --     },
    --   },
    -- },

    -- },
  }
end
return M
