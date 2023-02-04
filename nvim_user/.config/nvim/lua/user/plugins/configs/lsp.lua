local M = {}

local open_diagnostic = function()
  local opts = {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = "rounded",
    source = "always",
    prefix = " ",
    scope = "cursor",
  }
  vim.diagnostic.open_float(nil, opts)
end

function M.config()
  local lspconfig = require("user.core.utils").load_module("lspconfig")
  local util = require("user.core.utils").load_module("lspconfig/util")

  if not lspconfig then
    return {}
  end

  if not util then
    return {}
  end

  -- for emmet_ls
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local on_attach = function(client, bufnr)
    print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFf")
    if vim.g.autoformat_enabled ~= true then
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

    local lsp_signature = require("user.core.utils").load_module("lsp_signature")
    if lsp_signature then
      lsp_signature.on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded",
        },
      }, bufnr)
    end

    require("kosayoda/nvim-lightbulb")

    if vim.g.lsp_virtual_text_style == "popup" then
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true,
        signs = true,
      })
      --
      --   local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
      --   vim.api.nvim_create_autocmd("CursorHold", {
      --     callback = function()
      --       vim.diagnostic.open_float(nil, { focusable = false })
      --     end,
      --     group = diag_float_grp,
      --   })
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = open_diagnostic,
      })
    end
  end
  --
  local formatting = {
    -- control auto formatting on save
    async = false,
    format_on_save = {
      enabled = true, -- enable or disable format on save globally
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
    timeout_ms = 5000, -- default format timeout
    -- filter = function(client) -- fully override the default formatting function
    --   return true
    -- end
  }

  -- Add overrides for LSP server settings, the keys are the name of the server
  local config = {
    ["rust-analyzer"] = {
      settings = {
        -- HACK: https://github.com/simrat39/rust-tools.nvim/issues/300
        inlayHints = { locationLinks = false },
      },
    },
    sumneko_lua = {
      settings = {
        Lua = {
          format = {
            enable = false,
          },
        },
      },
    },
    emmet_ls = {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "eruby" },
    },
    grammarly = {
      init_options = {
        clientId = "client_4mT9RnW7h89wYs8T3rnzoA",
        filetypes = { "markdown" },
      },
    },
    -- example for addings schemas to yamlls
    solargraph = {
      init_options = {
        formatting = false, -- use rubocop
      },
    },
    jsonls = {
      init_options = {
        provideFormatter = false, -- use prettier
      },
    },
    html = {
      init_options = {
        provideFormatter = false, -- use prettier
      },
    },
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
      ["K"] = false,
      ["<c-space>"] = { open_diagnostic },
      -- ["gD"] = ":Glance definitions<cr>",
    },
  }

  local servers = {
    "sumneko_lua"
  }

  return {
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
    config = config,
    formatting = formatting,
    mappings = mappings,
    servers = servers,
  }
end

return M
