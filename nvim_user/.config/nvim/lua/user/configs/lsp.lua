local M = {}
function M.config()
  local lspconfig = require("user.core.utils").load_module("lspconfig")
  local util = require("user.core.utils").load_module("lspconfig/util")

  if not lspconfig then
    return {}
  end

  if not util then
    return {}
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "eruby" },
  })

  local on_attach = function(client, bufnr)
    -- set_default_formatter_for_filetypes("solargraph", { "ruby" })

    if client.name == "solargraph" then
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end

    if client.name == "sumneko_lua" then
      client.server_capabilities.document_formatting = false -- 0.7 and earlier
      client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
    end

    if client.name == "html" then
      client.server_capabilities.document_formatting = false -- 0.7 and earlier
      client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
    end

    if vim.g.autoformat_on_save ~= 1 then
      if client.server_capabilities.documentRangeFormattingProvider then
        local lsp_format_modifications = require("lsp-format-modifications")
        lsp_format_modifications.attach(client, bufnr, {
          format_on_save = true,
          format_callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end

    local vim = vim
    local opt = vim.opt

    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"
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
  local formatting = {
    -- control auto formatting on save
    format_on_save = {
      enabled = vim.g.autoformat_on_save == true, -- enable or disable format on save globally
      allow_filetypes = { -- enable format on save for specified filetypes only
        -- "go",
      },
      ignore_filetypes = { -- disable format on save for specified filetypes
        -- "python",
      },
    },
    disabled = { -- disable formatting capabilities for the listed language servers
      -- "sumneko_lua",
    },
    timeout_ms = 1000, -- default format timeout
    -- filter = function(client) -- fully override the default formatting function
    --   return true
    -- end
  }

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
        json = {
          schemas = {
            resume = {
              description = "JSON Resume",
              fileMatch = { "resume.json" },
              url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
            },
          },
        },
      },
    },
  }

  local mappings = {
    n = {
      ["<leader>la"] = false,
      ["<leader>lf"] = false,
      ["<leader>lh"] = false,
      ["<leader>lr"] = false,
      ["<leader>uf"] = false,
      ["gr"] = ":Glance references<cr>",
      -- ["gD"] = ":Glance definitions<cr>",
    },
  }

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
      "marksman",
      "jsonls",
      "rust_analyzer",
      "taplo",
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
    server_registration = {
      -- rust_analyzer = {
      --   completion = {
      --     addCallArgumentSnippets = false,
      --     addCallParenthesis = false,
      --   },
      -- },
      marksman = {
        cmd = { "marksman", "server" },
        filetypes = { "markdown" },
        root_dir = util.root_pattern(".git", ".marksman.toml"),
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      },
    },
    on_attach = on_attach,
    ["server-settings"] = server_settings,
    formatting = formatting,
    mappings = mappings,
  }
end

return M
