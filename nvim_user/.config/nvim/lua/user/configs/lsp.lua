local M = {}
function M.config()
  local lsp_installer = require("user.core.utils").load_module("nvim-lsp-installer")
  if not lsp_installer then
    return {}
  end

  -- lsp_installer.setup({
  --   automatic_installation = true,
  -- })

  local lspconfig = require("user.core.utils").load_module("lspconfig")
  local util = require("user.core.utils").load_module("lspconfig/util")

  if not lspconfig then
    return {}
  end

  if not util then
    return {}
  end

  local set_contains = function(set, val)
    for key, value in pairs(set) do
      if value == val then
        return true
      end
    end
    return false
  end

  local set_default_formatter_for_filetypes = function(language_server_name, filetypes)
    if not set_contains(filetypes, vim.bo.filetype) then
      return
    end

    local active_servers = {}

    vim.lsp.for_each_buffer_client(0, function(client)
      table.insert(active_servers, client.config.name)
    end)

    if not set_contains(active_servers, language_server_name) then
      return
    end

    vim.lsp.for_each_buffer_client(0, function(client)
      if client.name ~= language_server_name then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
      end
    end)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "eruby" },
  })

  -- lspconfig.gopls.setup({
  --   cmd = { "gopls", "serve" },
  --   filetypes = { "go", "gomod" },
  --   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  --   settings = {
  --     gopls = {
  --       analyses = {
  --         unusedparams = true,
  --       },
  --       staticcheck = true,
  --     },
  --   },
  -- })

  -- local map = vim.keymap.set
  -- local default_lsp_servers = {
  --   sumneko_lua = {},
  --   solargraph = {},
  --   gopls = {},
  --   tsserver = {},
  --   html = {},
  --   cssls = {},
  --   yamls = {},
  --   sqlls = {},
  --   eslint = {},
  -- }
  --
  -- for name, _ in pairs(default_lsp_servers) do
  --   local server_is_found, server = lsp_installer.get_server(name)
  --   if server_is_found and not server:is_installed() then
  --     print("Installing " .. name)
  --     server:install()
  --     server.gopls.setup({})
  --     -- vim.cmd("LspInstallInfo")
  --   end
  -- end

  local on_attach = function(client, bufnr)
    set_default_formatter_for_filetypes("solargraph", { "ruby" })
    -- client.resolved_capabilities.document_formatting = false
    -- client.resolved_capabilities.document_range_formatting = false

    -- vim.opt.foldmethod = "expr"
    -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    --
    -- require("lspconfig").gopls.setup({})
    -- require("aerial").on_attach(client, bufnr)

    -- require("lsp_signature").on_attach()
    -- TODO
    -- vim.cmd [[
    -- set shiftwidth=2
    -- set tabstop=2
    -- set expandtab
    -- ]]

    -- map("n", "<leader>lf", function()
    --   vim.lsp.buf.formatting_sync(nil, 2000)
    -- end, { desc = "Format code", buffer = bufnr })
  end

  -- add to the server on_attach function
  -- override the lsp installer server-registration function
  -- server_registration = function(server, opts)
  --   server:setup(opts)
  -- end

  -- Add overrides for LSP server settings, the keys are the name of the server
  local server_settings = {
    -- example for addings schemas to yamlls
    yamlls = {
      settings = {
        yaml = {
          schemas = {
            ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
            ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
          },
        },
      },
    },
  }

  local mappings = {}

  return {
    servers = {
      "sumneko_lua",
      "solargraph",
      "gopls",
      "tsserver",
      "html",
      "cssls",
      "yamlls",
      "sqlls",
      "eslint",
    },
    -- server_registration = {
    --   gopls = {
    --     cmd = { "gopls", "serve" },
    --     filetypes = { "go", "gomod" },
    --     root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    --     settings = {
    --       gopls = {
    --         analyses = {
    --           unusedparams = true,
    --         },
    --         staticcheck = true,
    --       },
    --     },
    --   },
    -- },
    on_attach = on_attach,
    ["server-settings"] = server_settings,
    mappings = mappings,
  }
end
return M
